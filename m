Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263163AbSJBQr7>; Wed, 2 Oct 2002 12:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263165AbSJBQr6>; Wed, 2 Oct 2002 12:47:58 -0400
Received: from mail.eastlink.de ([213.187.64.4]:50180 "EHLO mail.eastlink.de")
	by vger.kernel.org with ESMTP id <S263163AbSJBQrt>;
	Wed, 2 Oct 2002 12:47:49 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ralf Gerbig <rge-news@dialeasy.de>
To: Vojtech Pavlik <vojtech@ucw.cz>
Subject: 2.5 input drivers Synaptics touchpad
Date: Wed, 2 Oct 2002 18:24:54 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210021824.54927@hsp-law.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I just tried 2.5.40 and could not get the Synaptics touchpad on an Acer 
Travelmate 353 to work with either the synaptics driver for XFree 
at http://www.mobilix.org/software/synaptics/ or tpconfig at 
http://www.compass.com/synaptics/ gpm also does not like the synps2
protocol. Works as (im)ps/2 though.

I have tried with and without CONFIG_INPUT_MOUSE and CONFIG_MOUSE_PS2
using /dev/psaux and /dev/input/mice.

Below is the debug output of tpconfig on 2.4.18 with the 2.5.40 
differences on the right:

putbyte: write 0xe6
PS2_write: 1 bytes
PS2_write: 0xe6
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
putbyte: write 0xe8
PS2_write: 1 bytes
PS2_write: 0xe8
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
putbyte: write 00
PS2_write: 1 bytes
PS2_write:  0
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
putbyte: write 0xe8
PS2_write: 1 bytes
PS2_write: 0xe8
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
putbyte: write 00
PS2_write: 1 bytes
PS2_write:  0
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
putbyte: write 0xe8
PS2_write: 1 bytes
PS2_write: 0xe8
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
putbyte: write 00
PS2_write: 1 bytes
PS2_write:  0
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
putbyte: write 0xe8
PS2_write: 1 bytes
PS2_write: 0xe8
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
putbyte: write 00
PS2_write: 1 bytes
PS2_write:  0
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
putbyte: write 0xe9
PS2_write: 1 bytes
PS2_write: 0xe9
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
PS2_read: 1 bytes
PS2_read: 0x6                   PS2_read: 0x60
PS2_read: read 1
ps2_read_byte: read 0x6         ps2_read_byte: read 0x60
PS2_read: 1 bytes
PS2_read: 0x47                  PS2_read: 0x3
PS2_read: read 1
ps2_read_byte: read 0x47        ps2_read_byte: read 0x3
PS2_read: 1 bytes
PS2_read: 0x14                  PS2_read: 0xc8
PS2_read: read 1
ps2_read_byte: read 0x14        ps2_read_byte: read 0xc8
Found Synaptics Touchpad.       sorry nope ;)
putbyte: write 0xe6             putbyte: write 0xe7
PS2_write: 1 bytes
PS2_write: 0xe6                 PS2_write: 0xe7
PS2_write: done
PS2_read: 1 bytes
PS2_read: 0xfa
PS2_read: read 1
ps2_read_byte: read 0xfa
...
...
[query 00 => 0x6 0x47 0x14]     [query 00 => 0x60 0x3 0xc8]
                                fatal:
