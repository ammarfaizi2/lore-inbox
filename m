Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274168AbRISUkZ>; Wed, 19 Sep 2001 16:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274174AbRISUkR>; Wed, 19 Sep 2001 16:40:17 -0400
Received: from [209.202.108.240] ([209.202.108.240]:17932 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S274168AbRISUkB>; Wed, 19 Sep 2001 16:40:01 -0400
Date: Wed, 19 Sep 2001 16:40:05 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <Pine.LNX.4.33.0109191600100.29593-100000@terbidium.openservices.net>
Message-ID: <Pine.LNX.4.33.0109191635310.29593-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2001, Ignacio Vazquez-Abrams wrote:

> On Wed, 19 Sep 2001, Ignacio Vazquez-Abrams wrote:
>
> > From an Athlon 1050/KT133 (middle 3 of 5):
> >
> > Clear:
> > warm up run: 16653.33
> > 2.4 non MMX: 10803.33
> > 2.4 MMX fallback: 10576.67
> > 2.4 MMX version: 9824.33
> > faster_copy: 4416.67
> > even_faster: 4316.67
> >
> > Copy:
> > warm up run: 15268.33
> > 2.4 non MMX: 23765.33
> > 2.4 MMX fallback: 23629.33
> > 2.4 MMX version: 15316.67
> > faster_copy: 9352.00
> > even_faster: 9333.33
>
> Please note that the 'faster_copy' under clear is in fact 'faster_clear_page'.
> It got messed up in the post-processing of the results.

After Athlon patch:

clear_page() tests
clear_page function 'warm up run'        took 17860 cycles per page
clear_page function '2.4 non MMX'        took 11805 cycles per page
clear_page function '2.4 MMX fallback'   took 11777 cycles per page
clear_page function '2.4 MMX version'    took 12003 cycles per page
clear_page function 'faster_clear_page'  took 4416 cycles per page
clear_page function 'even_faster_clear'  took 4315 cycles per page

copy_page() tests
copy_page function 'warm up run'         took 14930 cycles per page
copy_page function '2.4 non MMX'         took 23337 cycles per page
copy_page function '2.4 MMX fallback'    took 23314 cycles per page
copy_page function '2.4 MMX version'     took 20293 cycles per page
copy_page function 'faster_copy'         took 9159 cycles per page
copy_page function 'even_faster'         took 9071 cycles per page

This is with 2.4.9-ac12-preempt1 in both cases and niced to -20. Subsequent
runs are very similar.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

