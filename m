Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315993AbSFJUIb>; Mon, 10 Jun 2002 16:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316023AbSFJUIa>; Mon, 10 Jun 2002 16:08:30 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:13008
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S315993AbSFJUI3>; Mon, 10 Jun 2002 16:08:29 -0400
Date: Mon, 10 Jun 2002 13:08:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020610200823.GN14252@opus.bloom.county>
In-Reply-To: <3D050350.A7011AE4@zip.com.au> <Pine.LNX.4.44.0206101403010.6159-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 02:03:42PM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Mon, 10 Jun 2002, Andrew Morton wrote:
> > wrt the __func__ thing: is it possible to do:
> > 
> > #if (compiler version test)
> > #define __FUNCTION__ __func__
> > #endif
> > 
> > to kill the 3.x warning?
> 
> #include <stdio.h>
> #define __FUNCTION__ __func__
> 
> int main(int argc, char **argv) {
>   int i;
> 
>   for (i = 0; i < argc; i++) {
>     printf(__FUNCTION__ " encountered argument ");
>     printf("%s\n", argv[i]);
>   }
> 
>   exit(0);
> }
> 
> Obviously, yes.

Nope.
$ gcc-3.1 -Wall -o foo foo.c
foo.c: In function `main':
foo.c:8: parse error before string constant

And line 8 is:
printf(__FUNCTION__ " encountered argument ");

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
