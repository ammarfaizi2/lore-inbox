Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbRE3JYM>; Wed, 30 May 2001 05:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262668AbRE3JYD>; Wed, 30 May 2001 05:24:03 -0400
Received: from t2.redhat.com ([199.183.24.243]:46321 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262667AbRE3JXx>; Wed, 30 May 2001 05:23:53 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200105300041.CAA04507@green.mif.pg.gda.pl> 
In-Reply-To: <200105300041.CAA04507@green.mif.pg.gda.pl> 
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrewm@uow.edu.au,
        p_gortmaker@yahoo.com, linux-kernel@vger.kernel.org (kernel list)
Subject: Re: [PATCH] net #3 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 10:11:57 +0100
Message-ID: <29071.991213917@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ankry@green.mif.pg.gda.pl said:
> -#ifdef CONFIG_ISAPNP 
> +#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE)) 

The result here would be a 3c509 module which differs depending on whether 
the ISAPNP module happened to be compiled at the same time or not. 

The ISAPNP-specific parts of the code aren't large. Please consider
including them unconditionally instead. 

--
dwmw2


