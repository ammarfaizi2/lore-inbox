Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbULFSEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbULFSEW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbULFSEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:04:22 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:34957 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261599AbULFSDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:03:53 -0500
Subject: Re: [RFC] dynamic syscalls revisited
From: Steven Rostedt <rostedt@goodmis.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Adrian Bunk <bunk@stusta.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412061026490.5219@montezuma.fsmlabs.com>
References: <1101741118.25841.40.camel@localhost.localdomain>
	 <20041129151741.GA5514@infradead.org>
	 <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
	 <1101748258.25841.53.camel@localhost.localdomain>
	 <20041205234605.GF2953@stusta.de>
	 <1102349255.25841.189.camel@localhost.localdomain>
	 <1102353388.25841.198.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0412061026490.5219@montezuma.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Mon, 06 Dec 2004 13:03:16 -0500
Message-Id: <1102356196.25841.204.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-06 at 10:32 -0700, Zwane Mwaikambo wrote:

> 
> I didn't know we were on a crusade to end all binary modules at all costs. 
> Why not just make _all_ symbols in the kernel EXPORT_SYMBOL_GPL then? I 
> really believe this is taking things to new levels of silliness, we should 
> also possibly consider adding code in glibc to stop proprietary 
> libraries/applications from running. What do you think?

Personally? I don't really care. But what goes in the main linux kernel
is decided by Linus, and he doesn't want dynamic system calls because...

Back in 2000 Linus wrote:

The problem is that dynamic system calls are not going to happen.

Why?

License issues. I will not allow system calls to be added from modules.
Because I do not think that adding a system call is a valid thing for a
module to do. It's that easy.

It's the old thing about "hooks". You must not sidestep the GPL by just
putting a hook in place. And dynamic system calls are the ultimate hook.

                Linus


And I was just trying to solve the one reason that I can understand why
Linus doesn't want dynamic system calls. If Linus had not stated this, I
would not be changing my original patch (which is still available and
doesn't do any of this nastiness).

-- Steve
