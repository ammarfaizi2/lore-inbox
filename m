Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSHGUnN>; Wed, 7 Aug 2002 16:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSHGUnM>; Wed, 7 Aug 2002 16:43:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:44796 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316659AbSHGUmf>; Wed, 7 Aug 2002 16:42:35 -0400
Subject: Re: [patch] tls-2.5.30-A1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Alexandre Julliard <julliard@winehq.com>,
       Luca Barbieri <ldb@ldb.ods.org>
In-Reply-To: <Pine.LNX.4.44.0208071115290.4961-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208071115290.4961-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Aug 2002 23:01:34 +0100
Message-Id: <1028757694.26935.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-07 at 19:33, Linus Torvalds wrote:
>  - keep the TLS entries contiguous, and make sure that segment 0040 (ie
>    GDT entry #8) is available to a TLS entry, since if I remember
>    correctly, that one is also magical for old Windows binaries for all
>    the wrong reasons (ie it was some system data area in DOS and in 
>    Windows 3.1)

Lots of BIOSes (a million monkeys bashing on typewriters will write
something that passes some BIOS vendor QA in about 2 seconds) illegally
assume that 0040: points at the BIOS data segment 0040 when making APM32
calls. Sufficient that Windows makea it so and its never going to get
corrected.

> Then, for double extra bonus points somebody should look into whether
> those damn PnP BIOS segments could be simply made to be TLS segments
> during module init. I don't know if that PnP stuff is required later or
> not.

PnPBIOS has to rewrite segments as it goes for data passing. It doesnt
really matter where you stuff them though.


