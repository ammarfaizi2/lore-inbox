Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbUL3Hkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbUL3Hkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 02:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUL3Hkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 02:40:49 -0500
Received: from wine.ocn.ne.jp ([220.111.47.146]:19186 "EHLO
	smtp.wine.ocn.ne.jp") by vger.kernel.org with ESMTP id S261565AbUL3Hki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 02:40:38 -0500
To: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org
Subject: Re: Is CAP_SYS_ADMIN checked by every program !?
From: Tetsuo Handa <from-linux-kernel@i-love.sakura.ne.jp>
References: <200412291347.JEH41956.OOtStPFFNMLJVGMYS@i-love.sakura.ne.jp>
	<9033584D-5A24-11D9-989E-000393ACC76E@mac.com>
In-Reply-To: <9033584D-5A24-11D9-989E-000393ACC76E@mac.com>
Message-Id: <200412301640.FCB13564.FtFPMSMGJtSOLVOYN@i-love.sakura.ne.jp>
X-Mailer: Winbiff [Version 2.43]
X-Accept-Language: ja,en
Date: Thu, 30 Dec 2004 16:40:40 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In message <9033584D-5A24-11D9-989E-000393ACC76E@mac.com>
   "Re: Is CAP_SYS_ADMIN checked by every program !?"
   "Kyle Moffett <mrmacman_g4@mac.com>" wrote:

> On Dec 28, 2004, at 23:47, Tetsuo Handa wrote:
> > It seems to me that every program calls capable(CAP_SYS_ADMIN),
> 
> Umm, the program has nothing to do with this.  Programs themselves have 
> no
> access to the kernel function "capable".  Probably something in the 
> kernel, perhaps
> triggered by libc or maybe just suid checks, is checking for 
> CAP_SYS_ADMIN. It's
> harmless and irrelevant, why do you care?

I'm developing a kernel patch that provides simple and handy
MAC(mandatory access control) functionality, much easier than SELinux.
And now I'm porting the patch from 2.4 to 2.6,
though the patch can't support LSM, for it refers 'struct vfsmount'.

At first, I doubted that some kernel function (do_execve(), memory management
functions, or any kernel functions that are always called by every process) is
doing this CAP_SYS_ADMIN checking. But may be this CAP_SYS_ADMIN checking is
caused by the Fedora Core 3's libc, not by the kernel.
I don't have 2.6 kernel environment other than Fedora Core 3.

But anyway, I have to give up checking for CAP_SYS_ADMIN .

Thank you.
--
Tetsuo Handa
