Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317859AbSHDPGM>; Sun, 4 Aug 2002 11:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317860AbSHDPGM>; Sun, 4 Aug 2002 11:06:12 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:21574 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S317859AbSHDPGL>; Sun, 4 Aug 2002 11:06:11 -0400
To: linux-kernel@vger.kernel.org
From: Jonathan Hudson <jonathan@daria.co.uk>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Oliver Feiler
References: <fa.egf7e0v.kk5a2@ifi.uio.no>
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
X-Newsgroups: fa.linux.kernel
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: daria.co.uk
Message-ID: <60bc.3d4d4347.5dd06@trespassersw.daria.co.uk>
Date: Sun, 04 Aug 2002 15:07:51 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <fa.egf7e0v.kk5a2@ifi.uio.no>,
	Oliver Feiler <kiza@gmx.net> writes:
OF> Hi,
OF> 
OF> Since 2.4.19 a usb mouse does not work anymore if
OF> 
OF> CONFIG_USB_HID=m
OF> and
OF> CONFIG_INPUT_MOUSEDEV=m
OF> 
OF> is set. It only works if both are compiled into the kernel. Yes, I have set
OF> CONFIG_USB_HIDINPUT=y.
OF> 
OF> I've also seen other complaints about usb mice not working in 2.4.19, I guess 
OF> that's the problem?
OF> 
OF> If the stuff is compiled as modules, everything seems to be fine. The kernel 
OF> messages are the same, everything is detected fine. Except that 'cat 
OF> /dev/input/mice' does not give any output if the driver is compiled as 
OF> module.
OF> 

Not so. USB Mouse works just fine here on 2.4.19.

$ lsmod
....
mousedev                4352   1
hid                    14112   0 (unused)
input                   3328   0 [mousedev hid]
....

CONFIG_INPUT=m
# CONFIG_INPUT_KEYBDEV is not set
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024

CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_USB_HIDDEV is not set

'cat /dev/input/mice' (a cat and mouse game?) gives output as well.

So there appears to be no generic 2.4.19 problem.

