Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266686AbUGLB7C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbUGLB7C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 21:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266687AbUGLB7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 21:59:02 -0400
Received: from mail011.syd.optusnet.com.au ([211.29.132.65]:25837 "EHLO
	mail011.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266686AbUGLB66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 21:58:58 -0400
References: <40F1BA46.9000207@blueyonder.co.uk> <20040711221818.GA30704@outpost.ds9a.nl> <40F1C568.2070503@blueyonder.co.uk> <20040712000137.GA3854@hobbes.itsari.int> <40F1E409.4040200@blueyonder.co.uk>
Message-ID: <cone.1089597462.444239.28499.502@pc.kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: sboyce@blueyonder.co.uk
Cc: Nuno Monteiro <nuno@itsari.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x Scheduler, preemption and responsiveness - puzzlement
Date: Mon, 12 Jul 2004 11:57:42 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-pc.kolivas.org-28499-1089597462-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-pc.kolivas.org-28499-1089597462-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Sid Boyce writes:

> Nuno Monteiro wrote:
> 
>>
>> On 2004.07.11 23:55, Sid Boyce wrote:
>>
>>> I've been wondering why this is, I can't remember what the BIOS says  
>>> about the hard drives, from memory it looked OK, I think it was set to
>>
>>
>> <snip snip>
>>
>>> PCI           IDE              nVidia Corporation nForce2 IDE (rev a2)
>>
>>
>> <snip snip>
>>
>>> # CONFIG_BLK_DEV_AMD74XX is not set
>>
>>
>> You don't have the driver for your IDE chipset compiled in. In the 
>> "ATA/ ATAPI/MFM/RLL support" under "Device Drivers" menu select "AMD 
>> and nVidia  IDE support". Also, you can disable the "Generic PCI IDE 
>> Chipset Support"  and the "VIA82CXXX chipset support" you seem to have 
>> enabled.
>>
>> Then you should be able to do DMA, and things will go a lot faster.
>>
>>
>> Hope this helps.
>>
>>
>>
>>         Nuno
> 
> Oops!, thanks. The previous motherboard used the VIA chipset, so that 
> got missed when I changed over.
> Regards
> Sid.

DMA disabled is perhaps the most common reason for poor performance under 
I/O loads. I think some cut down configurations that people have used from 
their 2.4 installations have missed the appropriate IDE driver.

Cheers,
Con

--=_mimegpg-pc.kolivas.org-28499-1089597462-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8fAWZUg7+tp6mRURAk7MAJ9B1blJeFktSPq5hbXxJ7l8mVFlwQCfXcT8
5FxlBQV4ybwFniJbE7RWs0s=
=KE3G
-----END PGP SIGNATURE-----

--=_mimegpg-pc.kolivas.org-28499-1089597462-0001--
