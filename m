Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263267AbTJKJBj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 05:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTJKJBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 05:01:39 -0400
Received: from smtp2.att.ne.jp ([165.76.15.138]:48548 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S263267AbTJKJBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 05:01:34 -0400
Message-ID: <227e01c38fd6$2fab61c0$5cee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test7 vs. mouse
Date: Sat, 11 Oct 2003 18:00:37 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A laptop has a trackball and 2 buttons.  Two.  Futatsu.  Dos (oops).  Deux.

SuSE 8.1 with kernel 2.4.19 and SuSE 8.2 with kernel 2.4.20 detected it
properly during installation.  The mouse worked in X11 under 2.4.19 until it
got messed up by the 2.6.0-test1 problem which I'll explain shortly.  The
mouse works in X11 under 2.4.20 because I could see how to stop it from
getting messed up by the 2.6.0-test7 problem which is probably the same
problem.

When 2.6.0-test1 booted under SuSE 8.1, SuSE's hardware inspector asked if I
wanted to let it configure the mouse.  I said yes.  After that, the mouse
worked in X11 under 2.6.0-test1 through test5, but the mouse no longer
worked in X11 under 2.4.19.

When 2.6.0-test5 through test7 boot under SuSE 8.2, SuSE's hardware
inspector asks if I want to let it configure the mouse.  I say no.  The
mouse continues to work in X11 under 2.6.0-test7 and 2.4.20.  But if I say
yes sometime, then I'm sure it will break the configuration for 2.4.20.
SuSE's hardware inspector detects the thing as a wheel mouse.  Maybe the
phantom wheel reported by 2.6.0-test7 doesn't hurt X11 under 2.6.0-test7.
But if the phantom wheel gets configured then maybe the non-existent wheel
which is not reported by 2.4.19 or 2.4.20 causes problems for X11 under
2.4.19 or 2.4.20.

In 2.6.0-test7, I tried Vojtech Pavlik's evtest program:
./evtest /dev/input/event0
Input driver version is 1.0.0
Input device ID: bus 0x11 vendor 0x2 product 0x1 version 0x29
Input device name: "PS/2 Logitech Mouse"
Supported events:
  Event type 0 (Sync)
  Event type 1 (Key)
    Event code 272 (LeftBtn)
    Event code 273 (RightBtn)
    Event code 275 (SideBtn)
  Event type 2 (Relative)
    Event code 0 (X)
    Event code 1 (Y)

Maybe 2.6.0-test7 reports a phantom side button and SuSE's hardware detector
turns that into a phantom wheel?

Do there really exist any mice which don't have a middle button and don't
have a wheel but which do have a side button?  If not, then perhaps whatever
is being detected here could be dismissed as an error instead of being
detected as a side button?

