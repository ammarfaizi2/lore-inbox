Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130214AbRCCBgz>; Fri, 2 Mar 2001 20:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130215AbRCCBgq>; Fri, 2 Mar 2001 20:36:46 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:8650 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130214AbRCCBgi>; Fri, 2 Mar 2001 20:36:38 -0500
Message-ID: <3AA04995.95532595@coplanar.net>
Date: Fri, 02 Mar 2001 20:32:05 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Favre Gregoire <greg@ulima.unil.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: IRQ advice (2.4.2-ac7)
In-Reply-To: <3AA040C4.3659B274@ulima.unil.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Favre Gregoire wrote:

> Hello,
>
> as I boot some times under windows, i have to change my IRQ for my PCI
> devices to (all) 9... and all the times I tried to boot that way under linux,
> it doesn't boot...
>
> So I haven't tested it that way for ages... and now with 2.4.2-ac7 i booted
> without any problem that way:
> cat /proc/interrupts                                                     03.03 1:52
>            CPU0
>   0:    3051534          XT-PIC  timer
>   1:      37390          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   8:          1          XT-PIC  rtc
>   9:    6193814          XT-PIC  HiSax, aic7xxx, EMU10K1, usb-uhci, saa7146(1), bttv
>  12:     314048          XT-PIC  PS/2 Mouse
>  14:      11820          XT-PIC  ide0
>  15:      42041          XT-PIC  ide1
> NMI:      27599
> LOC:    3051630
> ERR:          0
> MIS:          0
>
> Is it safe to do it that way?

I personally don't like sharing interrupts unles absolutely necessary.
Can you tell me why you need to do this?  I would recommend
disabling any devices you aren't using in the BIOS,
to free up interrupts.  (IE 2nd serial port, USB, 1st serial if you
only use PS/2 mouse)

If you don't use the floppy you might be able to disable it in BIOS.
I have one board that will use irq 6 for something more useful in this
case.

Also, changing PCI slot assignment of some cards (if you have spare
slots) can prevent sharing as well.

The BIOS on many boards will show PCI interrupt assignment
on the bootup screen.  Otherwise check in windows
device manager - double click on Computer node.

according to the above usage, you could use 4 (com1) (if not mouse or modem)
3 com2
5 unused
9,10,11

for devices.

Good luck!

