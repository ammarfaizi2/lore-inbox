Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbTENO77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 10:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbTENO77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 10:59:59 -0400
Received: from corky.net ([212.150.53.130]:36511 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S262385AbTENO75 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 10:59:57 -0400
Date: Wed, 14 May 2003 18:12:39 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Ahmed Masud <masud@googgun.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
In-Reply-To: <Pine.LNX.4.33.0305140954170.10993-100000@marauder.googgun.com>
Message-ID: <Pine.LNX.4.44.0305141805540.12748-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Ahmed Masud wrote:

> Well we definitely need a way to timeout keys.  The other reason is to be

Why ?  We keep a key per-process, and wipe it from memory as soon as the
process dies.  Its not time-related.

> able to "change your mind" about it while the key is being used.  This may
> not be a useful thing for now but think of encrypted swaps on the
> infamous: oopsies-i-tripped-over-a-wire-and-disconnected-network-file-system

Your swapfile is coming from a remote NFS mount ?  If your swap becomes
unavailable due to network problems, the swapped-out processes are
probably doomed anyway.

>
> Here we have a situation where we want to not have an expired key with
> valid data hanging out there.

Data is valid iff the owning process still lives.  When do we need to
expire a key while its process is still alive (or keep a key valid for
pages of a dead process) ?

	Yoav


