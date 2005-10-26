Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbVJZPvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbVJZPvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 11:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVJZPvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 11:51:03 -0400
Received: from smtp.rol.ru ([194.67.1.9]:58931 "EHLO smtp.rol.ru")
	by vger.kernel.org with ESMTP id S964797AbVJZPvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 11:51:00 -0400
Message-ID: <435FA5D8.2090406@rol.ru>
Date: Wed, 26 Oct 2005 19:50:48 +0400
From: Eugene Crosser <crosser@rol.ru>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, multiman@rol.ru, linux-kernel@vger.kernel.org
Subject: Re: Status of Marvell SATA driver (was Re: Trying latest sata_mv
 - and getting freeze)
References: <435F8AFF.3030404@rol.ru> <435F9737.3050409@emc.com>
In-Reply-To: <435F9737.3050409@emc.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA975B36649782148FBD6379A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA975B36649782148FBD6379A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Brett, thanks for quick response.

>> My hardware is SMP Supermicro with 6 disks on
>> Marvell MV88SX6081 8-port SATA II PCI-X Controller (rev 03)
>> and the sata_mv.c is version 0.25 dated 22 Oct 2005
>>
>> The thing works with "old" mvsata340 driver, but the "new" kernel with
>> your driver freezes when it starts to probe disks.  Even Magic SysRq
>> does not work.  The last lines I see on screen are like this:
>>
>> sata_mv version 0.25
>> ACPI: PCI Interrupt 0000:02:03.0[A] -> GSI 56 (level, low) -> IRQ 185
>> sata_mv(0000:02:03.0) 32 slots 8 ports unknown mode IRQ via MSI
>> ata1: SATA max UDMA/133 cmd 0x0 ctl 0xF8C22120 bmdma 0x0 irq 185
>> ata2: .... <same things>            0xF8C24120 ...
>> ...
>> ata8: .... <same thing>             0xF8C38120 ...
>> ATA: abnormal status 0x80 on port 0xF8C2211C
>> ... <five more lines identical to the above>
>> ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
>>
>> - and at this point it freezes hard.
>> Any suggestions for me?  Any information I can collect to help
>> troubleshooting?
[...]
> In the meantime, try turning off SMP and seeing if that makes a
> difference.  There still might be a problem with the spinlocks and if so
> it should go away in uniprocessor mode.

'nosmp' makes no difference.

If somebody on the list has suggestions or questions, please CC to me as
I am not subscribed to these maillists.

Eugene

--------------enigA975B36649782148FBD6379A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDX6XctQFsU5rTNjcRAoOGAKCl1bqUTEKT0ZZQ8XYakItru3mLMgCdErk8
3nMLudx8lFKfD0A4nIOtouI=
=hlFB
-----END PGP SIGNATURE-----

--------------enigA975B36649782148FBD6379A--
