Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWKEPEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWKEPEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 10:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWKEPEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 10:04:36 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:51597 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161254AbWKEPEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 10:04:35 -0500
Subject: Re: [PATCH 1/2] Add Legacy IDE mode support for SB600 SATA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: conke.hu@amd.com
Cc: akpm@osdl.org, Luugi Marsan <luugi.marsan@amd.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162733934.8525.88.camel@localhost.localdomain>
References: <20061103185420.B3FA6CBD48@localhost.localdomain>
	 <1162582216.12810.40.camel@localhost.localdomain>
	 <1162729080.8525.49.camel@localhost.localdomain>
	 <1162730726.31873.15.camel@localhost.localdomain>
	 <1162733934.8525.88.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Nov 2006 15:08:45 +0000
Message-Id: <1162739325.31873.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-11-05 am 21:38 +0800, ysgrifennodd Conke Hu:
>   Consider that the behavior itself of using the new motherboard, SB600,
> means a lot of change, so even if the user still use IDE driver, he also
> a need verification process.

It depends on the person but yes I had considered that.

> > This is not neccessarily misguided. They may want to do this.
>   But the SB600 SATA controller is really an AHCI controller. And that
> will lose high performance (and cannot use NCQ).

Maybe they want stability and certainty first.

>   OK, I am rewriting the patch based on the following considerations:
>   1. move these code to ahci driver, and add new code to PATA driver.
>   2. add new options to kernel configuration, and users can choose IDE
> driver or AHCI driver to support SB600 SATA when it is in IDE mode.

That seems fine to me. I would have thought putting the code you have
into the quirks.c file as you proposed was the better way to do this,
but with the addition of the 

#if defined (CONFIG_ATA_AHCI) || defined(CONFIG_ATA_AHCI_MODULE)

#endif

around it, was sufficient ?

