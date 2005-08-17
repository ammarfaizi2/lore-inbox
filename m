Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbVHQLNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVHQLNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 07:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVHQLNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 07:13:51 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:5588 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751063AbVHQLNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 07:13:50 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: help with PCI hotplug and a PCI device enabled after boot]
Date: Wed, 17 Aug 2005 13:15:22 +0200
User-Agent: KMail/1.8.2
References: <1124269343.4423.35.camel@localhost> <200508171147.22927@bilbo.math.uni-mannheim.de> <1124276090.4423.46.camel@localhost>
In-Reply-To: <1124276090.4423.46.camel@localhost>
Cc: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1281936.7LjSgiqYBP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508171315.32704@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1281936.7LjSgiqYBP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 17. August 2005 12:54 schrieb Mauro Carvalho Chehab:
>Rolf,
>
>Em Qua, 2005-08-17 =E0s 11:47 +0200, Rolf Eike Beer escreveu:
>> Mauro Carvalho Chehab wrote:
>> >    I need some help with PCI hotplug for allowing a new driver at
>> >Video4Linux.
>> >
>> >    I need memory to set its internal registers. Is there a way to make
>> >PCI drivers to allocate a memory region for the board?
>>
>> Use dummyphp instead of fakephp. It should handle this case. You can find
>> it here: http://opensource.sf-tec.de/kernel/dummyphp-2.6.13-rc1.diff
>
>	Didn't compile cleanly against -rc6. Do I need another patch or -mm
>series?
>
>WARNING: /lib/modules/2.6.13-rc6/kernel/drivers/pci/hotplug/dummyphp.ko
>needs unknown symbol pci_bus_add_resources

Damn, I should stop editing diffs by hand. Change this to=20
pci_bus_assign_resources and it should work. Sorry.

Eike

--nextPart1281936.7LjSgiqYBP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDAxxUXKSJPmm5/E4RAsw7AKCnBNin08WADDdOuZRIlg4w8rGVOwCglf7N
cYxBOcUqdWZTemehke1DFRg=
=Pm6U
-----END PGP SIGNATURE-----

--nextPart1281936.7LjSgiqYBP--
