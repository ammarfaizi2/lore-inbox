Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751243AbWA0EPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbWA0EPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 23:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWA0EPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 23:15:21 -0500
Received: from flock1.newmail.ru ([212.48.140.157]:31362 "HELO
	flock1.newmail.ru") by vger.kernel.org with SMTP id S1751243AbWA0EPU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 23:15:20 -0500
From: Andrey Borzenkov <arvidjaar@newmail.ru>
To: Rudolf Marek <r.marek@sh.cvut.cz>
Subject: Re: [lm-sensors] 2.6.15: lm90 0-004c: Register 0x13 read failed (-1)
Date: Fri, 27 Jan 2006 07:15:16 +0300
User-Agent: KMail/1.9.1
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
References: <200601142223.35838.arvidjaar@newmail.ru> <200601152248.07800.arvidjaar@newmail.ru> <43CAB1B7.6020903@sh.cvut.cz>
In-Reply-To: <43CAB1B7.6020903@sh.cvut.cz>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601270715.16881.arvidjaar@newmail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 15 January 2006 23:33, Rudolf Marek wrote:
> Hello all,
>
> > this appears simply a probing for non-existent i2c ports (correct me if I
> > am wrong) presumably by eeprom driver.
>
> yes I think you are right. (ADD/2 is the address of chip, that it tries to
> access)
>
> > Second block are errors from lm90 for different registers:
> >
> > Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (pre):
> > STS=04, TYP=10, CMD=01, ADD=99, DAT0=a0, DAT1=10
> > Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (post):
> > STS=14, TYP=10, CMD=01, ADD=99, DAT0=29, DAT1=10
> > Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (pre):
> > STS=04, TYP=10, CMD=08, ADD=98, DAT0=29, DAT1=10
> > Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Error: command never
> > completed
> > Jan 15 22:24:02 cooker kernel: i2c_adapter i2c-0: Transaction (post):
> > STS=04, TYP=10, CMD=08, ADD=98, DAT0=29, DAT1=10
> > Jan 15 22:24:02 cooker kernel: lm90 0-004c: Register 0x8 read failed (-1)

I still did not have much time to spend on it but booting today I suddenly got

i2c_adapter i2c-0: Unsupported chip (man_id=0x41, chip_id=0x42).

I begin to suspect that it is still lm90 (at least partly). Transacton did not 
fail (otherwise we were not here) but returned some strange value. Anyone 
knows if such chip really exits?

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD2Z5UR6LMutpd94wRAmaYAKCAdwCutdUWK+RFbQu9nMiLuIl6jACdGgj9
IHiDsWm37Xr4UWmQYbvwIOk=
=a1Ao
-----END PGP SIGNATURE-----
