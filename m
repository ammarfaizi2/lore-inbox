Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUFENia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUFENia (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 09:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbUFENia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 09:38:30 -0400
Received: from vhost-13-248.vhosts.internet1.de ([62.146.13.248]:31717 "EHLO
	spotnic.de") by vger.kernel.org with ESMTP id S261347AbUFENi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 09:38:27 -0400
In-Reply-To: <1086425211.4588.88.camel@imladris.demon.co.uk>
References: <200406041000.41147.cijoml@volny.cz> <F84CE3DA-B605-11D8-B781-000A958E35DC@axiros.com> <1086390590.4588.70.camel@imladris.demon.co.uk> <3F4B6D09-B6CA-11D8-B781-000A958E35DC@axiros.com> <1086425211.4588.88.camel@imladris.demon.co.uk>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-22-761311660"
Message-Id: <97F190B4-B6F5-11D8-B781-000A958E35DC@axiros.com>
Content-Transfer-Encoding: 7bit
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org
From: Daniel Egger <de@axiros.com>
Subject: Re: jff2 filesystem in vanilla
Date: Sat, 5 Jun 2004 15:38:13 +0200
To: David Woodhouse <dwmw2@infradead.org>
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-22-761311660
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

On 05.06.2004, at 10:46, David Woodhouse wrote:

> Can you be more specific? I don't know of any such problems. If they
> exist, they give me a potential excuse to update 2.4 to the current 
> code
> -- but to be honest I'd rather just leave it in maintenance mode.

Unfortunately not. We had misterious kernel oopses on bootup in
changing places in the source that appeared and vanished at will.
At first I had broken memory in mind but this wasn't the case. My next
guess was that the log checking (the looong version) might temporarily
overheat the passively cooled CPU but we could scrap that possibility as
well after reproducing the problem in a very cool environment.

After the tedious upgrade to the CVS version, everything works
like a charm and is now in never-touch-a-running system mode.

> CF is bog-roll technology. I wouldn't want to use it in production even
> with JFFS2 on it -- but at least when it gets confused you'll only lose
> a limited amount of data with JFFS2.

Works fine for us.

> If you're going to use JFFS2 on CF, you should really investigate using
> the write-buffer we implemented for NAND flash, but without the ECC
> parts. It'll mean you write each CF sector once rather than overwriting
> the sector each time you add a few bytes to the log.

Sounds good though not too useful for us because we typically do not
write much on the disc, just the configuration which only changes
once in a while.

However, do you have any specific pointers where to look?

Servus,
       Daniel

--Apple-Mail-22-761311660
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQMHMyjBkNMiD99JrAQKrOggAgtc2Q2CjraPUfzS/2IpTyVXsHMchoF/H
vel4p18Bzun/Xy0H8LAPwOS9ECjiwV4mpzwjcU5RZs+uN1irQbG3iLAih2mdm2uD
a8skP2Wi5ZiaO1WYYrsyTKlEDNEHk59cohZCnc1Hbjo2NMV6HTEVqmtdxz4ARtLr
Xd21H+hJvPT19wqx/PevlCUjQuj3PAX3xu4uCPZWD8On1TBYOLpU2anVtF+XMgFk
gaSHGTtMKOKOicC2vSk8B1iLCTGRbozaj6pnFQdBpsBl3yzvz/z2hcUecZXKu9ac
4ReLlUbisjYjYKhIefvoVMrwIOA02yeoO67RL41fVZe864/UGDMWNQ==
=ICg+
-----END PGP SIGNATURE-----

--Apple-Mail-22-761311660--

