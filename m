Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbTHULFO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 07:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262615AbTHULFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 07:05:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:7130 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262612AbTHULFJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 07:05:09 -0400
From: Patrick Dreker <patrick@dreker.de>
To: kenton.groombridge@us.army.mil, linux-kernel@vger.kernel.org
Subject: Re: nforce2 lockups
Date: Thu, 21 Aug 2003 13:05:05 +0200
User-Agent: KMail/1.5.9
References: <2224f3e221f996.221f9962224f3e@us.army.mil>
In-Reply-To: <2224f3e221f996.221f9962224f3e@us.army.mil>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200308211305.05848.patrick@dreker.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Thursday 21 August 2003 03:39 schrieb kenton.groombridge@us.army.mil zum 
Thema Re: nforce2 lockups:
> and it did cure my spurious interrupt problem, but unfortunately, my
> lockups have returned.
I managed to stabilize my Board, but I don't think the trick was obvious: 
Disable alle APIC related kernel Options (Local APIC and IO-APIC), disable 
APIC Mode in the BIOS. Check on reboot if it still talks about the APIC in 
the boot messages (How? IIRC mine did, which was why I did not think that 
disabling the APIC helped... Actually somehow it still was activated. Could 
ACPI be part of this?). If it does try noapic and/or nolapic boot options.

If you completely shut off the APIC it runs stable, but 1 of the 3 USB 
Controllers is not assigned an interrupt. All this with ACPI enabled (ACPI 
patch 20030730 and kernel 2.6.0-test3).

- -- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers or http://www.dreker.de/pubkey.asc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/RKdhcERm2vzC96cRAtjAAJ4y5oOm7uhtPqWtaS/S+mnWTr9C5gCdF3hK
2JQZ86psKDmWO74wxrINSRE=
=YbYq
-----END PGP SIGNATURE-----
