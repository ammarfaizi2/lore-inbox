Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273242AbRI0PNg>; Thu, 27 Sep 2001 11:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273254AbRI0PN1>; Thu, 27 Sep 2001 11:13:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:1286 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273242AbRI0PNN>;
	Thu, 27 Sep 2001 11:13:13 -0400
Date: Thu, 27 Sep 2001 12:13:23 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.9-ac15 sluggish
In-Reply-To: <1001602003.17481.7.camel@nomade>
Message-ID: <Pine.LNX.4.33L.0109271212100.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Sep 2001, Xavier Bestel wrote:

> with -ac10 no real bad behavior, just automake is working like crazy.
>
> with -ac15 the system starts disk-trashing immediately, xterms, ssh or
> telnet sessions are unresponsive for 20mn (after that I gave up and
> rebooted)

We discovered a merge bug, -ac15 has a few lines in
try_to_swap_out() 10 lines higher than they were in
the patch I sent to Alan ;)

This is fixed in the age+launder patch from my home
page ard in the vmscan.c I sent to Alan for -ac16.

If you want the patch:
	http://www.surriel.com/patches/

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

