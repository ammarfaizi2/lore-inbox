Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSE2WFq>; Wed, 29 May 2002 18:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315593AbSE2WFp>; Wed, 29 May 2002 18:05:45 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:38153 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315547AbSE2WFo>;
	Wed, 29 May 2002 18:05:44 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205292205.g4TM5e8348005@saturn.cs.uml.edu>
Subject: Re: [PATCH] intel-x86 model config cleanup
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 29 May 2002 18:05:40 -0400 (EDT)
Cc: jamagallon@able.es (J.A. Magallon),
        linux-kernel@vger.kernel.org (Lista Linux-Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox), davej@suse.de,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <3CF53C34.2080300@mandrakesoft.com> from "Jeff Garzik" at May 29, 2002 04:38:12 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:

> +choice 'Processor vendor' \
> +	"AMD			CONFIG_VENDOR_AMD \
> +	 Cyrix			CONFIG_VENDOR_CYRIX \
> +	 Generic		CONFIG_VENDOR_GENERIC \
> +	 IDT			CONFIG_VENDOR_IDT \
> +	 Intel			CONFIG_VENDOR_INTEL \
> +	 NationalSemiconductor	CONFIG_VENDOR_NATSEMI \
> +	 RiSE			CONFIG_VENDOR_RISE \
> +	 Transmeta		CONFIG_VENDOR_TRANSMETA \
> +	 VIA			CONFIG_VENDOR_VIA"	Generic
> +
> +if [ "$CONFIG_VENDOR_AMD" = "y" ]; then
> +	choice 'Processor family' \
> +	"386				CONFIG_M386 \
> +	 486				CONFIG_M486 \
> +	 K5/5x86			CONFIG_M586 \
> +	 K6/K6-II/K6-III		CONFIG_MK6 \
> +	 Athlon/Duron		CONFIG_MK7" Athlon
> +fi


This is still a mess. It's better to have one boolean
per processor, and order the processors by the year
in which they were most commonly sold.
