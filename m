Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbVKDXQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVKDXQf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVKDXQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:16:35 -0500
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:23669 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750909AbVKDXQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:16:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=5iTUYbGypQVcvJzCdgq+3LmyQw2py+Jt7JhFTFLLuKyIt9MAppFxKuBEjH3Bwy0EOiRudWnklJ74G4X0wAI4MqPjKG1pLlIW0H99M+D6wpeTb++OhUEXmMc3VJK4Ps+RiGbWFyTFFfpNZ5M162nDdVo1fr93Sp/u00AbFo2brF4=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] uml: fix hardcoded ZONE_* constants in zone setup
Date: Sat, 5 Nov 2005 00:21:47 +0100
User-Agent: KMail/1.8.3
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
References: <20051101170633.GB6448@ccure.user-mode-linux.org> <20051101203721.26156.11021.stgit@zion.home.lan> <20051104144632.55b92ea4.akpm@osdl.org>
In-Reply-To: <20051104144632.55b92ea4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511050021.48331.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 November 2005 23:46, Andrew Morton wrote:
> "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Remove usage of hardcoded constants in paging_init().

> An earlier patch from Jeff (below) already changed this code.

Andrew, yes indeed: quoting from my changelog (yep, I should have made it 
clearer):
> > By chance I spotted a bug in zones_setup involving a change to ZONE_*
> > constants, due to the ZONE_DMA32 patch from Andi Kleen (which is in -mm).
> > So, possibly, instead of zones_size[2] you will find zones_size[3] in the
> > code, but that change is wrong and this patch is still correct.
I'm talking exactly of this Jeff's change, and I did exactly what you did...

Thanks anyway for spending some time caring about this, it's nice to see 
attention on UML (sorry, no kidding and no complaining).

> Jeff's change looks rather wrong:
The original reason was done for -mm and ZONE_DMA32.

> #define MAX_NR_ZONES            3       /* Sync this with ZONES_SHIFT */
> 	zones_size[3] = highmem >> PAGE_SHIFT;
>
> which overindexes the local array.

> The above change is unmentioned in Jeff's changelog and I'll just drop that
> part.  Please confirm.
Yep, ACK.
> There are other parts of this patch whci are unchangelogged.  Please
> double-check the whole thing.

I will re-check again later, but the unchangelogged changes seem to be just 
long -> long long conversions.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
