Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268745AbUJKKGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268745AbUJKKGi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 06:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbUJKKGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 06:06:38 -0400
Received: from twin.jikos.cz ([213.151.79.26]:22233 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S268745AbUJKKGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 06:06:34 -0400
Date: Mon, 11 Oct 2004 11:56:18 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: Aboo Valappil <aboo@ABOOSPLANET.com>
cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Fabiano Ramos <ramos_fabiano@yahoo.com.br>,
       linux-kernel@vger.kernel.org
Subject: RE: how do you call userspace syscalls (e.g. sys_rename) from inside
 kernel
In-Reply-To: <3D6FC8DFDDD0CE44A3BE652A27AD42A54569@naya.aboosplanet.com>
Message-ID: <Pine.LNX.4.58.0410111152020.9978@twin.jikos.cz>
References: <3D6FC8DFDDD0CE44A3BE652A27AD42A54569@naya.aboosplanet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004, Aboo Valappil wrote:

> In the past I looked in to open, read and write a file from a kernel
> module.  But problem I faced using the kernel function was that it
> checks for the permissions of the file and path against the "current"
> process. For eg: open_namei() function ... My requirement was to open
> the file regardless of the permissions on the file and also not by
> modifying task_struct of the current process to change the permissions
> first ! I also wanted not associate the file with the current/any
> processes.  Any ideas on this ?

1) This is offtopic on LKML, kernelnewbies might be more apropriate list
2) look at set_fs() and filp_open() calls, they might be useful for you
3) Think twice if opening files from kernel is the thing you are willing 
to do

-- 
JiKos.

