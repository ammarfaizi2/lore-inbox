Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUFVHxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUFVHxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 03:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUFVHxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 03:53:32 -0400
Received: from mailgate1.siemens.ch ([194.204.64.131]:26496 "EHLO
	mailgate1.siemens.ch") by vger.kernel.org with ESMTP
	id S261232AbUFVHxa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 03:53:30 -0400
From: Marc Waeckerlin <Marc.Waeckerlin@siemens.com>
Organization: Siemens Schweiz AG
To: linux-kernel@vger.kernel.org
Subject: Continue: psmouse.c - synaptics touchpad driver sync problem
Date: Tue, 22 Jun 2004 09:52:59 +0200
User-Agent: KMail/1.6
X-Face: 9PH_I\aV;CM))3#)Xntdr:6-OUC=?fH3fC:yieXSa%S_}iv1M{;Mbyt%g$Q0+&K=uD9w$8bsceC[_/u\VYz6sBz[ztAZkg9R\txq_7]J_WO7(cnD?s#c>i60S
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406220953.01363.Marc.Waeckerlin@siemens.com>
X-OriginalArrivalTime: 22 Jun 2004 07:53:05.0688 (UTC) FILETIME=[F3990180:01C4582D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In May there was a posting Thorsten Hirsch and a patch reply by Dmitry 
Torokhov that did not help Thorsten.

I have exactely the same problem, and other people too. There's a thread on 
this topic with a more detailed problem description at:
http://www.linuxquestions.org/questions/showthread.php?s=&postid=1004645#post1004645

The problem was pested regarding to Kernel 2.6.6, but an upgrade to Kernel 
2.6.7 did not help me. My problem is even much worse:
 - The touchpad sometimes hangs and jumps.
 - Hitting on the touchpad does no more click the first button.
 - When I connect an external keyboard, the cursor somtimes jumps
   around like crazy and clicks around like fool, even if I don't
   click anything, but only move. When I then touch the keyboard,
   the mouse becomes normal for a while - on SuSE kernel 2.6.5,
   since. Since upgrade to kernel 2.6.7, does not become normal
   any more.
 - Sometimes the keyboard fails too, that means the without touching
   any key, a character is continually written, e.g. hundreds of "5"
   appear on the xterm. If i hit a key, a completely other character
   is printed, but not once but endlessly repeated.
 - Killing and restarting the X Server does not resolve the problem,
   reboot is the only thing that works!

It's really bad, I can't work anymore since I upgraded to SuSE 9.1 and kernel 
2.6...

Kernel messages:

A lot of during use of touch pad:
- psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 1
- psmouse.c: TouchPad at isa0060/serio2/input0 lost sync at byte 4

When using the external mouse and the mouse jumps around (repeated 2-3 times):
- atkbd.c: Spurious ACK on isa0060/serio0. Some program like XFree86, might be 
trying access hardware directly
- psmoouse.c: bad data from KBC - timeout


I'm not subscribed to the kernel mailing list due to the heavy traffic. Please 
CC me in your reply (marc dot waeckerlin at siemens dot com). Thank's.

Regards
Marc Wäckerlin
marc.waeckerlin.org
