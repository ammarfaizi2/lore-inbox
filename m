Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273131AbRIOXuk>; Sat, 15 Sep 2001 19:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273129AbRIOXuU>; Sat, 15 Sep 2001 19:50:20 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:62850 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S273130AbRIOXuI>; Sat, 15 Sep 2001 19:50:08 -0400
Date: Sat, 15 Sep 2001 19:50:31 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010915195030.A28703@cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What do you consider as good VM?

Because pages aren't 'aged' until there is swap allocated for them, your
kernel should actually work better if it has a lot of pages backed by
swap. The only thing is, we don't really make the right decision about
which pages to swap out, but that's just a detail.

IMHO. A large number of cached/active pages == good.

Jan

On Sun, Sep 16, 2001 at 12:43:35AM +0200, Peter Magnusson wrote:
> 2.4.7: good VM
> 2.4.8: not good
> 2.4.9: not good!!!++
> 2.4.10-pre4: quite ok VM, but put little more on the swap than 2.4.7
> 2.4.10-pre8: not good
> 2.4.10-pre9: not good ... Linux didnt had used any swap at all, then i
>              unrared two very large files at the same time. And now 104
>              Mbyte swap is used! :-( 2.4.7 didnt do like this.
>              Best is to use the swap as little as possible.
> 
> My cfg:
> 
> Real mem: 512684K (512 Mbyte)
> Swap    : 257032K
> compiled with: gcc version 2.96 20000731 (Linux-Mandrake 8.0 2.96-0.48mdk)
