Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316079AbSFJUR0>; Mon, 10 Jun 2002 16:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSFJUQw>; Mon, 10 Jun 2002 16:16:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2574 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316079AbSFJUP4>;
	Mon, 10 Jun 2002 16:15:56 -0400
Message-ID: <3D0508A9.AA798DF@zip.com.au>
Date: Mon, 10 Jun 2002 13:14:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Thunder from the hill <thunder@ngforever.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <3D050350.A7011AE4@zip.com.au> <Pine.LNX.4.44.0206101403010.6159-100000@hawkeye.luckynet.adm> <20020610200823.GN14252@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> ...
> Nope.
> $ gcc-3.1 -Wall -o foo foo.c
> foo.c: In function `main':
> foo.c:8: parse error before string constant
> 
> And line 8 is:
> printf(__FUNCTION__ " encountered argument ");

That's OK.  We need to convert all those to

	printf("%s encountered argument ", __FUNCTION__);

anyway.  That seems to be happening pretty quickly.

-
