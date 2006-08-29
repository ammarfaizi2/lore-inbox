Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWH2E76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWH2E76 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 00:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWH2E76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 00:59:58 -0400
Received: from father.pmc-sierra.com ([216.241.224.13]:54009 "HELO
	father.pmc-sierra.bc.ca") by vger.kernel.org with SMTP
	id S1750914AbWH2E75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 00:59:57 -0400
Message-ID: <478F19F21671F04298A2116393EEC3D50196DA@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
To: "'Paul Mackerras'" <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Ronald Lee <Ronald_Lee@pmc-sierra.com>,
       Radjendirane Codandaramane 
	<Radjendirane_Codandaramane@pmc-sierra.com>,
       Shawn Jin <Shawn_Jin@pmc-sierra.com>
Subject: RE: PPC 2.6.11.4 kernel panics while doing insmod (store fault wi
	th d cbst in icache_flush_range)
Date: Mon, 28 Aug 2006 21:59:51 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Processor: PPC440
Dcbst takes the store fault.

-----Original Message-----
From: Paul Mackerras [mailto:paulus@samba.org] 
Sent: Monday, August 28, 2006 9:35 PM
To: Kallol Biswas
Cc: linux-kernel@vger.kernel.org; linuxppc-dev@ozlabs.org; Ronald Lee; Radjendirane Codandaramane; Shawn Jin
Subject: Re: PPC 2.6.11.4 kernel panics while doing insmod (store fault with d cbst in icache_flush_range)

Kallol Biswas writes:

>         mr      r6,r3
> 1:      dcbst   0,r3
>         addi    r3,r3,L1_CACHE_LINE_SIZE
>         bdnz    1b
> 
> The instruction takes a store fault (DST bit, bit 8 of ESR gets set), 
> kernel panics with oops (signal 11).

What processor are you using?

Which instruction takes a store fault?

Paul.
