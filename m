Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVDPDUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVDPDUQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 23:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVDPDUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 23:20:16 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:15372 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262607AbVDPDSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 23:18:50 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: bunk@stusta.de (Adrian Bunk)
Subject: Re: [2.6 patch] drivers/serial/8250_acpi.c: fix a warning
Cc: adobriyan@mail.ru, akpm@osdl.org, bjorn.helgaas@hp.com,
       rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.ne
Organization: Core
In-Reply-To: <20050416023852.GI4831@stusta.de>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DMdfg-00047d-00@gondolin.me.apana.org.au>
Date: Sat, 16 Apr 2005 13:08:36 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
>> drivers/serial/8250_acpi.c doesn't use CONFIG_ symbols.
> 
> 8250_acpi.c #include's <acpi/acpi_bus.h> which requires config.h .
> 
> In the Linux kernel, it's more common to put such header dependencies 
> for header files into the C files, but if the ACPI people agree a patch 

I disagree with this assertion.  Try

grep -l linux/config.h include/linux/*.h | wc -l

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
