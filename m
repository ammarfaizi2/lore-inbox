Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbTL1CeH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbTL1CeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:34:07 -0500
Received: from smtp2.att.ne.jp ([165.76.15.138]:24269 "EHLO smtp2.att.ne.jp")
	by vger.kernel.org with ESMTP id S264930AbTL1CeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:34:02 -0500
Message-ID: <173a01c3cceb$0432e110$43ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.0 vs. vga option
Date: Sun, 28 Dec 2003 11:32:44 +0900
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

On a machine with a Neomagic NM2200 [MagicGraph 256AV] VGA controller, under
2.6.0, boot parameter vga=0x317 causes a blank screen and might be hanging
the entire machine.  There is no response to Ctrl-Alt-Del.  Holding the
power switch for 4 seconds results in a warning beep from the BIOS and then
power down.

This is very similar to problems that were reported during 2.6.0-test days,
with an older Neomagic chip and smaller screen.  I don't recall if
Ctrl-Alt-Del might have yielded a reboot at that time.

As always, this can be fixed by booting 2.4.20.  Or by omitting the vga=
parameter.

Oddly, I have found some combination of drivers to compile as built-in and
some to compile as modules, so that early in the boot sequence the screen
automatically switches from 80x25 to somewhere around 128x40 even without
the vga= parameter.  No free penguin though.

