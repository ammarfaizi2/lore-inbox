Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265631AbSJYAEW>; Thu, 24 Oct 2002 20:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265694AbSJYAEW>; Thu, 24 Oct 2002 20:04:22 -0400
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:54289 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S265631AbSJYAEV>; Thu, 24 Oct 2002 20:04:21 -0400
Date: Fri, 25 Oct 2002 02:10:23 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021025001023.GD3933@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3DB82ABF.8030706@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB82ABF.8030706@colorfullife.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

On Thu, 24 Oct 2002, Manfred Spraul wrote:

> AMD recommends to perform memory copies with backward read operations 
> instead of prefetch.
> 
> http://208.15.46.63/events/gdc2002.htm
> 
> Attached is a test app that compares several memory copy implementations.
> Could you run it and report the results to me, together with cpu, 
> chipset and memory type?
> 
> Please run 2 or 3 times.

Here you are, three runs, shown is: floor((n1+n2+n3)/3)
where n_i is the results (cycles/page) of the i-th run of the respective test

Duron 700, Via KT133, PC133 (manuf. date 12/2000): (machine was NOT idle)

'warm up run'         11445
'2.4 non MMX'         22374
'2.4 MMX fallback'    20075
'2.4 MMX version'     17611
'faster_copy'         11103
'even_faster'          7225
'no_prefetch'          6549

Athlon XP1600+, Via KT333, PC2100 (manuf. date 10/2002): (idle)

'warm up run'         14106
'2.4 non MMX'         15382
'2.4 MMX fallback'    15416
'2.4 MMX version'     14103
'faster_copy'          8793
'even_faster'          8797
'no_prefetch'          6351

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iQCVAwUBPbiL5ydEoB0mv1ypAQEmpAP/UDkcx+UnItqTVcQzec3zDIUmrznZHkwa
0+cVgeMjg3e0QwIX85bmioicKlIw4WNz+AJZOyasFA+5VbxPBghkEkFOLzIzI9Bh
Eq2/uGNWrcwLfhIhsVgy0c/XgYLFoCY7mfH2oSs8+3TvIXIxhJoz7CsnaF+STk8e
wkWHfLN2+B0=
=4cF6
-----END PGP SIGNATURE-----
