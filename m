Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318217AbSHDU3U>; Sun, 4 Aug 2002 16:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSHDU3U>; Sun, 4 Aug 2002 16:29:20 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51961 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318217AbSHDU3U>; Sun, 4 Aug 2002 16:29:20 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028492596.1293.535.camel@ldb>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk> 
	<1028492596.1293.535.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 22:51:13 +0100
Message-Id: <1028497873.15495.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 21:23, Luca Barbieri wrote:
> Added, with the exception that sfence is only used if CONFIG_X86_OOSTORE
> is not defined (currently never).

OOSTORE should be defined for all WINCHIP family processors. We run the
winchip cpus in weak store ordered mode which requires a store fence
when we want to be sure the cpu/memory/pci view is consistent for a DMA

