Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262549AbSJBSjH>; Wed, 2 Oct 2002 14:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbSJBSjG>; Wed, 2 Oct 2002 14:39:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:43186 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262549AbSJBSjC>;
	Wed, 2 Oct 2002 14:39:02 -0400
Date: Wed, 2 Oct 2002 20:44:28 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ralf Gerbig <rge-news@dialeasy.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 input drivers Synaptics touchpad
Message-ID: <20021002204428.A20378@ucw.cz>
References: <200210021824.54927@hsp-law.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210021824.54927@hsp-law.de>; from rge-news@dialeasy.de on Wed, Oct 02, 2002 at 06:24:54PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 06:24:54PM +0200, Ralf Gerbig wrote:

> Hi Vojtech,
> 
> I just tried 2.5.40 and could not get the Synaptics touchpad on an Acer 
> Travelmate 353 to work with either the synaptics driver for XFree 
> at http://www.mobilix.org/software/synaptics/ or tpconfig at 
> http://www.compass.com/synaptics/ gpm also does not like the synps2
> protocol. Works as (im)ps/2 though.
> 
> I have tried with and without CONFIG_INPUT_MOUSE and CONFIG_MOUSE_PS2
> using /dev/psaux and /dev/input/mice.

Yes, for 2.5 I still have to write a synaptics touchpad kernel driver
for it to work properly.

> Below is the debug output of tpconfig on 2.4.18 with the 2.5.40 
> differences on the right:
> 
> putbyte: write 0xe6
> PS2_write: 1 bytes
> PS2_write: 0xe6
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> putbyte: write 0xe8
> PS2_write: 1 bytes
> PS2_write: 0xe8
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> putbyte: write 00
> PS2_write: 1 bytes
> PS2_write:  0
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> putbyte: write 0xe8
> PS2_write: 1 bytes
> PS2_write: 0xe8
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> putbyte: write 00
> PS2_write: 1 bytes
> PS2_write:  0
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> putbyte: write 0xe8
> PS2_write: 1 bytes
> PS2_write: 0xe8
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> putbyte: write 00
> PS2_write: 1 bytes
> PS2_write:  0
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> putbyte: write 0xe8
> PS2_write: 1 bytes
> PS2_write: 0xe8
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> putbyte: write 00
> PS2_write: 1 bytes
> PS2_write:  0
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> putbyte: write 0xe9
> PS2_write: 1 bytes
> PS2_write: 0xe9
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> PS2_read: 1 bytes
> PS2_read: 0x6                   PS2_read: 0x60
> PS2_read: read 1
> ps2_read_byte: read 0x6         ps2_read_byte: read 0x60
> PS2_read: 1 bytes
> PS2_read: 0x47                  PS2_read: 0x3
> PS2_read: read 1
> ps2_read_byte: read 0x47        ps2_read_byte: read 0x3
> PS2_read: 1 bytes
> PS2_read: 0x14                  PS2_read: 0xc8
> PS2_read: read 1
> ps2_read_byte: read 0x14        ps2_read_byte: read 0xc8
> Found Synaptics Touchpad.       sorry nope ;)
> putbyte: write 0xe6             putbyte: write 0xe7
> PS2_write: 1 bytes
> PS2_write: 0xe6                 PS2_write: 0xe7
> PS2_write: done
> PS2_read: 1 bytes
> PS2_read: 0xfa
> PS2_read: read 1
> ps2_read_byte: read 0xfa
> ...
> ...
> [query 00 => 0x6 0x47 0x14]     [query 00 => 0x60 0x3 0xc8]
>                                 fatal:

-- 
Vojtech Pavlik
SuSE Labs
