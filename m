Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbUBHAnw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 19:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUBHAnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 19:43:52 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:1498 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261575AbUBHAnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 19:43:49 -0500
From: Hagen.Pelkner@t-online.de (Hagen Pelkner)
To: <linux-kernel@vger.kernel.org>
Subject: Problem: setkeycodes do not work in 2.6.2-bk1 and 2.6.3-rc1 
Date: Sun, 8 Feb 2004 01:44:00 +0100
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAEBobsZqrtkWnWiyBHp5t18KAAAAQAAAArNEqS3wv2E2aRg75ZfLZOgEAAAAA@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Seen: false
X-ID: EwzOTyZYoeFrL0yLYTZQux-bJDibolUG6pLdtw+6-hzqeCS+8ZXK61
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the patchsets for 2.6.2-bk1 and 2.6.3-rc1 includes a patch for the 
file linux/driver/char/keyboard.c 

---------
@@ -202,7 +202,7 @@
 		return -EINVAL;
 
 	oldkey = INPUT_KEYCODE(dev, scancode);
-	INPUT_KEYCODE(dev, scancode) = keycode;
+	SET_INPUT_KEYCODE(dev, scancode, oldkey);
....
---------

With the new version of the keyboard-driver, on my machine (*) works 
the setkeycodes programm no more. 
( is "SET_INPUT_KEYCODE(dev, scancode, keycode)" the right way ? )

(*) Athlon 1400 (i386 arch)

Example: I'm use setkeycodes e05e 120 ( Powerkey send "KeyboardSignal" ) 
( and others )


bye
Hagen Pelkner ( aka Harry :-) )


