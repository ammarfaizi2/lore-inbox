Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129813AbRBZTV0>; Mon, 26 Feb 2001 14:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbRBZTVR>; Mon, 26 Feb 2001 14:21:17 -0500
Received: from rachael.franken.de ([193.175.24.38]:44810 "EHLO
	rachael.franken.de") by vger.kernel.org with ESMTP
	id <S129813AbRBZTVG>; Mon, 26 Feb 2001 14:21:06 -0500
Date: Mon, 26 Feb 2001 20:13:08 +0100
From: Matthias Bruestle <m@mbsks.franken.de>
To: Junichi Morita <jun1m@mars.dti.ne.jp>
Cc: linux-kernel@vger.kernel.org, tridge@linuxcare.com
Subject: Re: Power management on Sony C1Vx
Message-ID: <20010226201308.K5112@mbsks.franken.de>
In-Reply-To: <20010225205521.C3253@mbsks.franken.de> <200102261648.BAA09972@smtp8.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200102261648.BAA09972@smtp8.dti.ne.jp>; from jun1m@mars.dti.ne.jp on Tue, Feb 27, 2001 at 01:48:26AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mahlzeit


On Tue, Feb 27, 2001 at 01:48:26AM +0900, Junichi Morita wrote:
> I think ... This <Fn+Fxx> keys controled by SPIC(Sony Programmable I/O Control Device).
> Download a picturebook application from
>  http://samba.org/picturebook/
> and make it.

Done.

> and check with this command...
>  # capture -j
> then press <Fn+Fxx> keys. May be you can see the press event...
> Here is a event data...
>  <Fn+ESC>  : event 0x10 0x29  &  event 0x10 0x28
>  <Fn+F1>   : event 0x11    ------ same -----
>  <Fn+F2>   :       0x12
>     :                :    <F3> -> <F11> : 0x13 -> 0x1b

Works, but it seams a bit flakey. Sometimes I get 0xXX 0x29 and 0xXX 0x28
and sometimes only 0xXX 0x28. The "jog dial" is even more flakey. This
has the third variation of no events at all.

> > - standby makes the display black, but switches not the backlights off.
> >   The only way to go back to normal is by switching to a text console
> >   and then back to X.
> Recompile the your Kernel with "Enable console blanking using APM" option.
> then the backlights off.(only text console)
> I checked Kernel 2.2.17,2.2.18 & 2.4.2

The C1Vx does support as I have now heard in principle no APM, so I
would have to use ACPI. If I want to use ACPI I cannot compile in APM,
else it tries to use APM. A way to switch of the backlights, which
works very reliable, is shuting the notebook. :)

> My VAIO could(can) go into suspend mode....but never wakeup.
> as same as APM case.

I seams every C1Vx does other things.

> You can use the internal USB-Memory-Stick device with Kernel 2.2.18 and usb-storage module.

"modprobe usb-storage" does dectect the floppy, does detect the memory
stick (prorietary crap) and hangs then forever. (With 2.4.2 and 2.4.2-ac3)

> and the sound module is ymfpci.
> take care about ymfpci module... because, some time I get a NOISE!!!

I had this also, the I installed the ALSA driver and no problems again
with it.


Mahlzeit

endergone Zwiebeltuete

-- 
live free or die
