Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263272AbSJCNoX>; Thu, 3 Oct 2002 09:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263273AbSJCNoX>; Thu, 3 Oct 2002 09:44:23 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:25840 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263272AbSJCNoW>; Thu, 3 Oct 2002 09:44:22 -0400
Subject: Re: [PATCH] EVMS core 4/4: evms_biosplit.h
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kevin Corry <corryk@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       evms-devel@lists.sourceforge.net
In-Reply-To: <02100307382404.05904@boiler>
References: <02100307382404.05904@boiler>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 14:57:03 +0100
Message-Id: <1033653423.28255.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void
> +bio_split_setup(char * split_name, char * bio_name)
> +{
> +	/* initialize MY bio split record pool */
> +	my_bio_split_slab = kmem_cache_create(split_name,
> +						sizeof
> +						(struct bio_split_cb),
> +						0, SLAB_HWCACHE_ALIGN,
> +                                                NULL, NULL);
> +	if (!my_bio_split_slab) {
> +		panic("unable to create EVMS Bio Split cache.");

If IBM are going to be doing telco grade stuff you could start now by
failing politely in this case 8)



