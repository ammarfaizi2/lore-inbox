Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTJJH2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 03:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbTJJH2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 03:28:42 -0400
Received: from ns.suse.de ([195.135.220.2]:54485 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261956AbTJJH2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 03:28:41 -0400
Date: Fri, 10 Oct 2003 09:28:38 +0200
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Taner Halicioglu <taner@taner.net>
Subject: Re: 2.6.0-test7 oops in proc_pid_stat
Message-ID: <20031010072838.GA17401@suse.de>
References: <20031009130409.GA740@suse.de> <200310092204.h99M4Ro28540@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200310092204.h99M4Ro28540@mail.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Oct 09, Linus Torvalds wrote:

> Olaf Hering wrote:
> > 
> > Linux version 2.6.0-test7 (olaf@zert152) (gcc version 3.2.2) #2 SMP Thu
> > Oct 9 08:49:29 CEST 2003
> > 
> > Unable to handle kernel NULL pointer dereference at virtual address
> 0000003c
> 
> Ok, this seems to be due to the move of the job control fields from
> the task structure to the signal structure.
> 
> That looks like a bad idea, and the best thing to do is likely to just
> revert the whole thing.

I have reverted these two patches and fixed the reject in sched.h, no
oops since 9 hours.

# 03/10/05      akpm@osdl.org[torvalds] 1.1451.4.16
# [PATCH] move job control fields from task_struct to

# 03/10/05      akpm@osdl.org[torvalds] 1.1451.4.17
# [PATCH] fix "compat ioctl consolidation" for "move job

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
