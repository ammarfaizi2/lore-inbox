Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129554AbRBVW0f>; Thu, 22 Feb 2001 17:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131173AbRBVW0Z>; Thu, 22 Feb 2001 17:26:25 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4102 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129554AbRBVW0U>; Thu, 22 Feb 2001 17:26:20 -0500
Subject: Re: [PATCH] use correct include dir for build tools
To: rread@datarithm.net (Robert Read)
Date: Thu, 22 Feb 2001 22:28:58 +0000 (GMT)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010222123940.A20319@tenchi.datarithm.net> from "Robert Read" at Feb 22, 2001 12:39:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14W4EP-00055G-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  FINDHPATH      = $(HPATH)/asm $(HPATH)/linux $(HPATH)/scsi $(HPATH)/net
>  
>  HOSTCC         = gcc
> -HOSTCFLAGS     = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
> +HOSTCFLAGS     = -I$(HPATH) -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer

That seems odd. Which build tools need to find kernel includes for this kernel
not the standard C includes
