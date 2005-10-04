Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbVJDDw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVJDDw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 23:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVJDDw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 23:52:26 -0400
Received: from h80ad24d0.async.vt.edu ([128.173.36.208]:19140 "EHLO
	h80ad24d0.async.vt.edu") by vger.kernel.org with ESMTP
	id S1751116AbVJDDw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 23:52:26 -0400
Message-Id: <200510040351.j943pe6B015123@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Vadim Lobanov <vlobanov@speakeasy.net>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Your message of "Mon, 03 Oct 2005 22:07:22 BST."
             <20051003210722.GI8548@lkcl.net> 
From: Valdis.Kletnieks@vt.edu
References: <20051002204703.GG6290@lkcl.net> <Pine.LNX.4.63.0510021704210.27456@cuia.boston.redhat.com> <20051002230545.GI6290@lkcl.net> <Pine.LNX.4.58.0510021637260.28193@shell2.speakeasy.net> <20051003005400.GM6290@lkcl.net> <1128367120.26992.44.camel@localhost.localdomain>
            <20051003210722.GI8548@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1128397899_3613P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 03 Oct 2005 23:51:39 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1128397899_3613P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 Oct 2005 22:07:22 BST, Luke Kenneth Casson Leighton said:

>  whereas, would you see it more reasonable for a commodity-level
>  chip to be something like 32- or even 64- ultra-RISC cores of
>  between 5000 and 10,000 gates each, resulting in a processor
>  of about 50% cache memory and 50% processing plus associated
>  parallel bus architecture at around 1 million gates?

Read your history - especially IBM's 801 chipset, which became the RT,
and why they then replaced that with the Power architecture...

>  running at oh say 1ghz or with careful design effort focussed on the
>  RISC cores maybe even 2ghz, resulting in 128 total GigaOps if you
>  go for 64 cpus @ 2ghz.  that's a friggin lot of processing power
>  for a 1m gates processor!!

Good.  Were you planning to run the ucLinux branch on this, or include all
the pieces needed to support virtual memory?  And do it inside that 10K gate
budget, too (hint - how many gates will you burn just doing a TLB big enough
to get the performance of mapping a virtual->real address to be good enough?)

You might want to read up on all the fun that IBM went through in designing
memory subsystems that can keep even the Power4 and Power5 chipsets fed too,
or the interesting stuff that SGI has to do to allow 64/128/512 processors
to beat up on a memory system - I'm sure there's some pretty high gate count
involved there..

If you're doing 64 10K-gate cores, you've blown 64% of your 1M gate budget.
You've got only 320K gates left to build cache *and* virtual memory support to
make that 1M gate budget.  And yes, you need a cache, as IBM found out on
their RT processor.....


--==_Exmh_1128397899_3613P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDQfxLcC3lWbTT17ARAnBLAJ9/YvG2U5h9lewcNvn1eCCTFuZsFgCeNTsq
eQMF8jN7ou01I/V/HlOmluU=
=Oi8O
-----END PGP SIGNATURE-----

--==_Exmh_1128397899_3613P--
