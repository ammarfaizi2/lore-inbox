Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVK1XAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVK1XAj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVK1XAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:00:39 -0500
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:56967 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1750884AbVK1XAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:00:38 -0500
Message-ID: <438B8861.1050408@jtholmes.com>
Date: Mon, 28 Nov 2005 17:44:49 -0500
From: jt <jt@jtholmes.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: psmouse.c  in Kernel fails but succeeds  as Module
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Was using 2.6.11.4 and the GlidePoint worked there just fine

In 2.6.14.2 the Alps GlidePoint Mouse stopped being detected when
I compile Kernel with

CONFIG_MOUSE_PS2=y

After boot up

cat of /proc/bus/input/devices  displays:

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
H: Handlers=kbd event0
B: EV=40001
B: SND=6

I: Bus=0011 Vendor=0001 Product=0001 Version=abba
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event1
B: EV=120013
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=045e Product=0040 Version=0300
N: Name="Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)"
P: Phys=usb-0000:00:13.0-1/input0
H: Handlers=mouse0 event2
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103



However, when  I compile Kernel with

CONFIG_MOUSE_PS2=m

and after boot up execute
modprobe psmouse
manually

the Alps GlidePoint is detected thus

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
H: Handlers=kbd event0
B: EV=40001
B: SND=6

I: Bus=0011 Vendor=0001 Product=0001 Version=abba
N: Name="AT Translated Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event1
B: EV=120013
B: KEY=4 2000000 3802078 f840d001 f2ffffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=7

I: Bus=0003 Vendor=045e Product=0040 Version=0300
N: Name="Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)"
P: Phys=usb-0000:00:13.0-1/input0
H: Handlers=mouse0 event2
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=103

I: Bus=0011 Vendor=0002 Product=0008 Version=0000
N: Name="PS/2 Mouse"
P: Phys=isa0060/serio1/input1
H: Handlers=mouse1 event3
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

I: Bus=0011 Vendor=0002 Product=0008 Version=7321
N: Name="AlpsPS/2 ALPS GlidePoint"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse2 event4
B: EV=f
B: KEY=420 0 70000 0 0 0 0 0 0 0 0
B: REL=3
B: ABS=1000003

and GlidePoint Works fine in Console Mode and X etc.

I have my work around for the problem, but wondered if
someone like Dimitry T. would like me to perform a little
debugging and send them the output so others wont have
to face this problem.

Yes, the 2.6.11.4 had
CONFIG_MOUSE_PS2=y

I dont take the kernel message feed so please reply to me
and I will keep a lookout in  LMKL

thanks
jt







