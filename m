Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSFJUDv>; Mon, 10 Jun 2002 16:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSFJUDu>; Mon, 10 Jun 2002 16:03:50 -0400
Received: from p50887BDF.dip.t-dialin.net ([80.136.123.223]:4997 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315946AbSFJUDs>; Mon, 10 Jun 2002 16:03:48 -0400
Date: Mon, 10 Jun 2002 14:03:42 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andrew Morton <akpm@zip.com.au>
cc: Tom Rini <trini@kernel.crashing.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
In-Reply-To: <3D050350.A7011AE4@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206101403010.6159-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 10 Jun 2002, Andrew Morton wrote:
> wrt the __func__ thing: is it possible to do:
> 
> #if (compiler version test)
> #define __FUNCTION__ __func__
> #endif
> 
> to kill the 3.x warning?

#include <stdio.h>
#define __FUNCTION__ __func__

int main(int argc, char **argv) {
  int i;

  for (i = 0; i < argc; i++) {
    printf(__FUNCTION__ " encountered argument ");
    printf("%s\n", argv[i]);
  }

  exit(0);
}

Obviously, yes.

Regards,
Thunder
-- 
German attitude becoming        |	Thunder from the hill at ngforever
rightaway popular:		|
       "Get outa my way,  	|	free inhabitant not directly
    for I got a mobile phone!"	|	belonging anywhere

