Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTEMCMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 22:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbTEMCMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 22:12:38 -0400
Received: from corky.net ([212.150.53.130]:14530 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S262621AbTEMCMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 22:12:37 -0400
Date: Tue, 13 May 2003 05:25:15 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <200305122200_MC3-1-3890-B108@compuserve.com>
Message-ID: <Pine.LNX.4.44.0305130515220.15817-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   And when I type 'swapoff' at the command line the whole scheme fails
> unless I am a perfect robot sysadmin and always remember to wipe the
> file.  This needs to 'fail safe' and it needs to be done within the kernel
> to be considered a working feature.
>

mv /sbin/swapoff /sbin/swapoff.real
cat >/sbin/swapoff
#!/bin/sh
/sbin/swapoff.real
/sbin/wipeswap
^D
chmod +x /sbin/swapoff


Any system that doesn't consider this fail-safe enough, shouldn't rely on
this zeroing operation even if performed by the kernel.  See the URL I
posted in this thread about encrypted swap.

