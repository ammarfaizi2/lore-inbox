Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317816AbSHHRlw>; Thu, 8 Aug 2002 13:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317815AbSHHRlF>; Thu, 8 Aug 2002 13:41:05 -0400
Received: from ool-182fa350.dyn.optonline.net ([24.47.163.80]:48004 "EHLO
	nikolas.hn.org") by vger.kernel.org with ESMTP id <S317799AbSHHRjz>;
	Thu, 8 Aug 2002 13:39:55 -0400
Date: Thu, 8 Aug 2002 13:42:58 -0400
From: Nick Orlov <nick.orlov@mail.ru>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pdc20265 problem.
Message-ID: <20020808174258.GA5622@nikolas.hn.org>
Mail-Followup-To: Andre Hedrick <andre@linux-ide.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.96.1020807183410.14463B-100000@gatekeeper.tmr.com> <Pine.LNX.4.10.10208080344290.24560-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10208080344290.24560-100000@master.linux-ide.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 03:50:19AM -0700, Andre Hedrick wrote:
> On Wed, 7 Aug 2002, Bill Davidsen wrote:
> 
> > I would just as soon use a boot option as to try and make it a compile
> > option, and I think that many people just use a compiled kernel and never
> > change, which argues for a reasonable default (most pdc20265) ARE
> > currently offboard, and an easy way to change it.
> 
> There are ZERO pdc20265's offboard, only pdc20267's were in both options.
> This is the direct asic packaging.  Thus all pdc20265 have the right to be
> listed as onboard.

Could you comment next couple lines of code (2.4.19-vanilla):

==========================================
#else /* !CONFIG_PDC202XX_FORCE */
[ ... skipped ... ]
        {DEVID_PDC20265,"PDC20265" .... OFF_BOARD ..... },
                                        ^^^^^^^^^
[ ... skipped ... ]
#endif
==========================================

Another bug? Just typo?
Why author put PDC20265 in off-board list ?

> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 

-- 
With best wishes,
        Nick Orlov.

