Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265650AbSKTXzR>; Wed, 20 Nov 2002 18:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbSKTXzQ>; Wed, 20 Nov 2002 18:55:16 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:48772 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265650AbSKTXzP>; Wed, 20 Nov 2002 18:55:15 -0500
Subject: Re: RFC - new raid superblock layout for md driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
In-Reply-To: <15836.5807.792124.255167@notabene.cse.unsw.edu.au>
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au>
	<1037801381.3267.17.camel@irongate.swansea.linux.org.uk> 
	<15836.5807.792124.255167@notabene.cse.unsw.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 00:30:52 +0000
Message-Id: <1037838652.3241.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 23:11, Neil Brown wrote:
> This brings up endian-ness?  Should I assert 'little-endian' or should
> the code check the endianness of the magic number and convert if
> necessary?
> The former is less code which will be exercised more often, so it is
> probably safe.

>From my own experience pick a single endianness otherwise some tool will
always get one endian case wrong on one platform with one word size.

> 
> So:
>   All values shall be little-endian and times shall be stored in 64
>   bits with the top 20 bits representing microseconds (so we & with
>   (1<<44)-1  to get seconds.

Could do - or struct timeval or whatever
