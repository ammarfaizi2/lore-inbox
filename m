Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSFYR1W>; Tue, 25 Jun 2002 13:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSFYR1V>; Tue, 25 Jun 2002 13:27:21 -0400
Received: from atlas.inria.fr ([138.96.66.22]:18818 "EHLO atlas.inria.fr")
	by vger.kernel.org with ESMTP id <S315720AbSFYR1U>;
	Tue, 25 Jun 2002 13:27:20 -0400
Message-Id: <200206251727.g5PHRKY16997@atlas.inria.fr>
Content-Type: text/plain; charset=US-ASCII
From: Nicolas Turro <Nicolas.Turro@sophia.inria.fr>
To: linux-kernel@vger.kernel.org
Subject: PS2 -> USB magic
Date: Tue, 25 Jun 2002 19:27:20 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

on my laptop (compaq armada m300), i used to plug an usb mouse,
and it was 'seen' as a ps2 mouse by Xfree, without any usb module loading 
(kernel 2.2.18, with custom configure options)

root@polaire# ls -l /dev/mouse /dev/psmouse
lrwxrwxrwx   1 root     root           12 Jun 25 15:27 /dev/mouse -> 
/dev/psmouse
crw-rw-rw-   1 root     sys       10,   1 Jun 25 15:27 /dev/psmouse

and :
Section "InputDevice"
    Identifier  "Mouse1"
    Driver      "mouse"
    Option      "Device"        "/dev/mouse"
    Option      "Protocol"      "PS/2"
    Option      "Emulate3Buttons"
EndSection

In my XF86Config ...
It was kinda magic.... 

Anyway, i compiled a 2.4.17 kernel (with more or less the same configure 
options, but it was a pain for usb), and now the same 'magic' doesn't work....
I must use usbcore, hid, mousedev, uhci modules in order to use my usb 
mouse...

Can someone explain me how it worked in 2.2.18 without those modules,
and is it possible to make the same magic work in 2.4.17 ?

Nicolas
