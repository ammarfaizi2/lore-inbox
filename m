Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWE1U2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWE1U2s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 16:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWE1U2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 16:28:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:46991 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750898AbWE1U2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 16:28:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=nuULtsgk3cNkA6WSdtfKwQkBtqc6/IpHgE6zEsHV3A1neNWVSVgaGWtJBmSSG2CtdFRBktToq43/fyWgWNP8sB8mmX6vxHf13v08+eMpJ2cIEXxm/EyxSRqguQm5m9li9ygplFT+fD/7FTdqbOdxKD3M6Rb+Z93cphEWAGkaMEc=
Message-ID: <447A0809.7050207@gmail.com>
Date: Sun, 28 May 2006 22:28:34 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: matthieu castet <castet.matthieu@free.fr>
CC: Linux and Kernel Video <video4linux-list@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, linux-kernel@vger.kernel.org,
       Nathan Laredo <laredo@gnu.org>
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se>	<44799D24.7050301@gmail.com>	<m3slmui1cr.fsf@zoo.weinigel.se>	<4479D167.4020203@gmail.com> <m3odxihxvp.fsf@zoo.weinigel.se> <4479DF88.2040500@gmail.com> <4479E1F8.4030606@free.fr>
In-Reply-To: <4479E1F8.4030606@free.fr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

matthieu castet napsal(a):
> Jiri Slaby wrote:
>> Christer Weinigel napsal(a):
>>> Why not?  There's an I2C bus with a bunch of devices on it.  Isn't it
>>> possible to do an I2C scan and if it doesn't match what's supposed to
>>> be on the card fail the probe and release the PCI resources?
>>
>> This is an older method not used for device drivers, but only for
>> searching for
>> busses or i2c et al, of which drivers stands aside and controls the
>> device.
>>
>>> If there is no FPGA or the FPGA fails to respond, that should also be
>>> a fairly good indicator that it is not a stradis board.
>>
>> Yup, but pci probing doesn't have such mechanism.
> Hum ?
> The driver have to return an error (negative value) in the probbing
> function if it detect that the card fails to respond correctly.
I meant something other. Now it's clear, ignore that sentence in my reply,
please. Of course, there is a mechanism how driver can tell layers upwards it
can't drive the device.

regrads,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEeggJMsxVwznUen4RAprXAKCNwSJpVIItEPm7cPSLvtS5xeT/gwCeI6UP
4SXefweIJhM0j2DA1wxlyZ4=
=RmKM
-----END PGP SIGNATURE-----
