Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVG3Nti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVG3Nti (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 09:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVG3Nti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 09:49:38 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:29409 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S262964AbVG3Nth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 09:49:37 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: karim@opersys.com
Subject: Re: Average instruction length in x86-built kernel?
Date: Sat, 30 Jul 2005 15:49:26 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <42EAA05F.4000704@opersys.com>
In-Reply-To: <42EAA05F.4000704@opersys.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2132518.cAhaKmWGy9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507301549.32528.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2132518.cAhaKmWGy9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Karim,

On Friday 29 July 2005 23:32, Karim Yaghmour wrote:
> Googling around, I can find references claiming that the average
> instruction length on x86 is anywhere from 2.7 to 3.5 bytes, but I
> can't find anything studying Linux specifically.

This is not that hard to find out yourself:

Just study the output od objdump -d and average the differences
of the first hex number in a line printed, which are followed by a ":"

e.g.


scripts/kconfig/mconf.o:     file format elf32-i386

Disassembly of section .text:

00000000 <init_wsize>:
       0:	83 ec 1c             	sub    $0x1c,%esp
       3:	8d 44 24 10          	lea    0x10(%esp),%eax
       7:	89 44 24 08          	mov    %eax,0x8(%esp)

so avg(3-7, 3-0) = 2.5

and so on...


Happy analyzing!


Regards

Ingo Oeser


--nextPart2132518.cAhaKmWGy9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC64VsU56oYWuOrkARAiZ+AJ9TQ3UyB4ZB6WysiJmPR3yV4eIm4ACeMFK2
mSTw/IX/wva5yRQscoMdgcs=
=oUto
-----END PGP SIGNATURE-----

--nextPart2132518.cAhaKmWGy9--
