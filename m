Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280586AbRKFVn0>; Tue, 6 Nov 2001 16:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280587AbRKFVnP>; Tue, 6 Nov 2001 16:43:15 -0500
Received: from klawatti.watchguard.com ([64.74.30.161]:47881 "EHLO
	watchguard.com") by vger.kernel.org with ESMTP id <S280586AbRKFVnD>;
	Tue, 6 Nov 2001 16:43:03 -0500
Date: Tue, 6 Nov 2001 13:33:28 -0800 (PST)
From: "B. James Phillippe" <bryanxms@ecst.csuchico.edu>
Reply-To: "B. James Phillippe" <bryanxms@ecst.csuchico.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel: clarify GPL for kernel modules
Message-ID: <3d2665697814777d3aa83560a8709ed23be85904@watchguard.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been doing some research on use of the Linux kernel as a foundation
operating system to drive a generally non-GPL product, and I have some
questions.  I have done some research independently and I have also been a
touch-and-go kernel hacker for a few years.[1]

My questions stem from a link I found[2] which states that although the
kernel is licensed under the GPL, there is a special exception which
basically allows full use of the kernel from user-space via exposed API's
(e.g. system calls) without GPL-migration.  I interpret this to mean you
can basically build anything you want around the kernel without infringing
upon the license.  However, in that same link it is stated that
"modules/drivers linked with the Linux kernel do fall under standard GPL
licensing".  This seems to contradict what I have observed from a number of
vendors who have written Linux kernel modules under their own licensing
terms to drive their proprietary hardware.  Examples include encryption
chip makers, ethernet board manufacturers and even my IBM ThinkPad (shipped
with Linux) comes with a little "tp" module to launch apps when the
"ThinkPad" button is pressed.  :-)

With this said, my basic questions are:

1.) Is it permissible to write non-GPL kernel modules as long as you do
not touch the kernel?

2.) Is it permissible to write non-GPL kernel modules which depend on
modifications to the GPL kernel, such as to expose functions/objects which
are not normally exposed?  For example, export a symbol from within the
kernel that is not normally exported, such that said non-GPL kernel module
can call that function/read that datum.

3.) Variation on #2: ... which depend on additions to the GPL kernel, such
as addition of a new API or hooks which allow the non-GPL kernel module to
link into the kernel?  Assuming the modifications to the kernel remain GPL,
of course.  This approach aims to preverse the sanctity of the GPL in the
kernel, but add a "plugin" API that some non-GPL thing (or GPL thing, or
anything really) can link into.

I appreciate any helpful responses to these questions.

[1] contributed a few bugfixes to the kernel and other utilities (modutils,
etc), some tiny contributions to the tga framebuffer, enhancements to Brad
Keryan's slram driver, a 1:1 NAT patch for 2.0, and other little bits lost
in the background noise.

[2] http://www.oncoresystems.com/linux_gpl.htm

cheers,
-bp
--
# bryanxms at ecst dot csuchico dot edu       Support the American Red Cross
# Software Engineer                               http://www.redcross.org


