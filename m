Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264929AbTL1CeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbTL1CeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:34:04 -0500
Received: from smtp2.att.ne.jp ([165.76.15.138]:21453 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S264929AbTL1CeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:34:01 -0500
Message-ID: <173901c3cceb$02d68560$43ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0 and mice
Date: Sun, 28 Dec 2003 11:31:59 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a machine with an Alps touchpad, I have built 2.6.0 several times.

1.  Some of the SuSE 8.2 boot-time operations report various errors which I
am trying to minimize.  Somehow I got modules partly working, and some of
the boot-time errors can be minimized by compiling some drivers as modules
instead of built into the kernel.  Changing the Event interface from
built-in to module removed one boot-time error.  Changing the Joystick
interface from none to module removed another.  However, I cannot build the
Mouse interface as a module.  In Input device support, "make xconfig" offers
Mouse interface (NEW) with settable Horizontal and Vertical resolutions but
no settable Y or N or M.  The help information says that Y and M are
possibilities but doesn't say how I can say or choose either of them.  The
help information says that M would make the module called mousedev which
would surely remove one more boot-time error.  In a while I might try
editing the .config file using either "vi" or "make menuconfig", but surely
"make xconfig" should also be capable.

2.  Also in Input device support, there is a section on Mice, PS/2 mouse,
and Synaptics TouchPad.  These I compiled in and they don't seem to be
causing any problems.  It seems that the Alps TouchPad is being recognized
as an Intelli/Wheel mouse instead of being recognized as a Synaptics
TouchPad, which is unfortunate but not really causing any problems.  I've
read that Synaptics is most common in foreign countries but Alps is most
common in Japan.  Help information says I could make a module called psmouse
but this wouldn't resolve the boot-time error about mousedev so I'm still
compiling these in instead of changing them to modules.

3.  In section Character devices there is another section on Mice.  Help
says that most people have serial mice.  Funny, the other section on Mice
and PS/2 mouse didn't say that most people have serial mice.  Anyway this
section is older, and I always used to say that I had a Bus Mouse, because I
knew I didn't have a serial mouse.  In 2.4 there was a separate section for
USB mouse which I had to use for one machine, and I also enable it for other
machines just to allow the possibility of attaching additional mice, but
that isn't a problem.  Now there is the confusion of which is the opposite
of a serial mouse, is it a Bus Mouse or is it a PS/2 mouse?  Do I need to
enable both Bus Mouse and PS/2 mouse, or just one of these?  As an
experiment one time I tried deselecting Bus Mouse and it made no difference,
but the Help information and the existence of these multiple options sure
cause confusion.

