Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266826AbUBRAg3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266152AbUBRAds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:33:48 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:55451 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266908AbUBRAdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:33:02 -0500
Message-ID: <20040217163228.qz5ogcw4ggc0w8cg@carlthompson.net>
X-Priority: 3 (Normal)
Date: Tue, 17 Feb 2004 16:32:28 -0800
From: Carl Thompson <cet@carlthompson.net>
To: Pavel Machek <pavel@suse.cz>
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: hard lock using combination of devices
References: <20040216214111.jxqg4owg44wwwc84@carlthompson.net>
	<200402170854.22973.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040216231401.3ig4kksk4k8g8440@carlthompson.net>
	<200402171149.49985.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040217061400.z9r4gss0gsockws4@carlthompson.net>
	<20040217223319.GB666@elf.ucw.cz>
In-Reply-To: <20040217223319.GB666@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=_28xki6om0olc";
	protocol="application/pgp-signature"; micalg="pgp-sha1"
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 205.158.175.194
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format and has been PGP signed.

--=_28xki6om0olc
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

At the moment I am.  But I also tried native Linux drivers too with the same
result.  I've tried Windows drivers under DriverLoader and ndiswrapper as well
as the native Aetheros driver, the native ADMTek driver and another native
driver the name of which escapes me right now.  It's definitely not a driver
problem because I've tried several with the same results.

BTW, Driverloader is actually a very slick package.  For 802.11a/g parts, it
definitely seems to be the way to go if stability is an issue.  While it is a
commercial product it's worth the $20US if you use high-speed wireless cards.
Ndiswrapper is also nice but it is not as complete as DriverLoader currently
and does not work with many cards.  As for the Windows NDIS drivers that are
run with them, they actually tend to be very stable and I have no problem with
running them from a "purity" standpoint.  I believe in doing what works, and
right now nothing is working with Linux.

The native drivers are in various states but all have problems which make them
undesirable.  The Aetheros driver is best of the bunch, though.

Thanks,
Carl Thompson

Quoting Pavel Machek <pavel@suse.cz>:

> Hi!
>
>> >>> Your box share IRQs in a big way :)
>> >>
>> >>Your point?
>> >
>> >While shared interrupts can in theory work right,
>> >lots of hardware and/or drivers do not handle
>> >that.
>>
>> First, the two devices in question are not on the same interrupt.  
>> Second, it
>> is very difficult in this day in age to build a system without interrupt
>> sharing.  While I agree that it's better to have as few devices sharing as
>> possible, there are simply too many devices in modern systems and too few
>> interrupts.  Interrupt sharing needs to work on modern hardware and needs to
>> work in Linux.  This notebook is pretty typical in its interrupt 
>> distribution
>
>>            CPU0         0:   41027968          XT-PIC  timer
>>   1:      26061          XT-PIC  i8042
>>   2:          0          XT-PIC  cascade
>>   8:          1          XT-PIC  rtc
>>   9:       2020          XT-PIC  acpi
>>  10:    2187181          XT-PIC  yenta, driverloader
>>  11:        111          XT-PIC  ALI 5451
>>  12:    2399118          XT-PIC  i8042
>>  14:     169829          XT-PIC  ide0
>>  15:          1          XT-PIC  ide1
>> NMI:          0 LOC:   41036749 ERR:     275764
>> MIS:          0
>
> Does that mean you are actually using windows driver for your wireless
> card? At that point ... no wonder it breaks ;-).
> 								Pavel
> --
> When do you have a heart between your knees?
> [Johanka's followup: and *two* hearts?]




--=_28xki6om0olc
Content-Type: application/pgp-signature
Content-Description: PGP Digital Signature
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBAMrKc6IVDCG8k9vsRAqo0AJ0cQvV6iOlsO5P77m+JVemD2w1CZgCgpeyi
PMFW6+6QNy8RVPVLeFeXHJQ=
=DZXV
-----END PGP SIGNATURE-----

--=_28xki6om0olc--

