Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272540AbRIKTip>; Tue, 11 Sep 2001 15:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272547AbRIKTif>; Tue, 11 Sep 2001 15:38:35 -0400
Received: from puma.inf.ufrgs.br ([143.54.11.5]:15120 "EHLO inf.ufrgs.br")
	by vger.kernel.org with ESMTP id <S272540AbRIKTiY>;
	Tue, 11 Sep 2001 15:38:24 -0400
Date: Tue, 11 Sep 2001 16:38:32 -0300 (EST)
From: Roberto Jung Drebes <drebes@inf.ufrgs.br>
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org
Subject: Re: Duron kernel crash (i686 works)
In-Reply-To: <154763769.20010911115644@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.GSO.4.21.0109111623500.13708-100000@jacui>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2001, VDA wrote:

> Please report to lkml as much details about your BIOSes (both older
> and newer) as you can.
> 
> You may be interesting in this msg:
> --------------------------------------------------------------
>         ...
>         kernel_fpu_end();
> +       from-=4096;
> +       to-=4096;
> +       if(memcmp(from,to,4096)!=0) {
> +               printk("Athlon bug!"); //add printout of from,to,...?
> +               memcpy(to,from,4096);
> +       }
> }

I then get 'Athlon bug!' Still oopses.

> 
> Comparing K7 and MMX fast_copy_page...
> 
> Does replacing movntq->movq fix makes oops go avay?

Yes, it does! Didn't tested exaustively, but it seems to go away!

As said earlier, this happens after upgrading from BIOS YH to 3R in the
KT7A-RAID. The processor is a Duron 800 not overclocked.

--
Roberto Jung Drebes <drebes@inf.ufrgs.br>
Porto Alegre, RS - Brasil
http://www.inf.ufrgs.br/~drebes/

