Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272415AbRIFIuJ>; Thu, 6 Sep 2001 04:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272424AbRIFIt7>; Thu, 6 Sep 2001 04:49:59 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:38162 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S272415AbRIFIto>;
	Thu, 6 Sep 2001 04:49:44 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: PNPBIOS: warning: >= 16 resources, overflow?
Date: 6 Sep 2001 08:42:40 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9pedo0.3eu.kraxel@bytesex.org>
In-Reply-To: <999763976.1544.16.camel@LNX.iNES.RO>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 999765760 3551 127.0.0.1 (6 Sep 2001 08:42:40 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dumitru Ciobarcianu wrote:
>  
>  While browsing trough my boot messages I noticed this warning.
>  
>  PNPBIOS: warning: >= 16 resources, overflow?
>  
>  This appeared somewhere in 2.4.9-ac series.
>  Is it something I should be worried about ?

>  See below bootlog.txt, .config and lspci

lspnp (comes with pcmcia-cs) would be more intresting.  The pnpbios code
fills a "struct pci_dev" for each device reported by the pnpbios, and it
looks like your portable has one device with alot ressources, so the
ressources array in struct pci_dev can't hold them all.  There is a
#define in include/linux/pci.h for the array size ...

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
