Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318458AbSHURGn>; Wed, 21 Aug 2002 13:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318460AbSHURGn>; Wed, 21 Aug 2002 13:06:43 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:17656 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318458AbSHURGl>; Wed, 21 Aug 2002 13:06:41 -0400
Date: Wed, 21 Aug 2002 13:10:48 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Mala Anand <manand@us.ibm.com>
Cc: alan@lxorguk.ukuu.org.uk, davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Bill Hartner <bhartner@us.ibm.com>
Subject: Re: (RFC): SKB Initialization
Message-ID: <20020821131048.B8001@redhat.com>
References: <OF9AEE9308.79FD144F-ON87256C1C.004716B7@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF9AEE9308.79FD144F-ON87256C1C.004716B7@boulder.ibm.com>; from manand@us.ibm.com on Wed, Aug 21, 2002 at 11:59:44AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2002 at 11:59:44AM -0500, Mala Anand wrote:
> The patch reduces the numer of cylces by 25%

The data you are reporting is flawed: where are the average cycle 
times spent in __kfree_skb with the patch?  Without that information, 
there is no basis for conclusion as the total time spent in these 
two routines is unknown.  At worst, I'd have to assume this lack of 
scientific method is an attempt to hide some aspect of the resulting 
behaviour, but I hope that isn't the case.

		-ben

> Baseline on Linux 2.5.25 kernel:
> -------------------------------
> 
>                                 CPU 0                 CPU 1
>                                ------                 ------
> Avg cycles in alloc_skb:        64.05                 203.39
> Avg cycles in __kfree_skb:     127.54                 228.95
>                                ------                 -------
> Total Avg Cycles               191.59                 432.34
>                                ------                 -------
> 
> # of times alloc_skb called:      235,478            2,060,422
> # of times __kfree_skb called:  2,063,276              232,359
> 
> 
> Linux 2.5.25+Skbinit Patch:
> --------------------------
>                               CPU 0                   CPU 1
>                               -----                   -----
>  Avg cycles in alloc skb:     237.21                  230.91
> 
>  # of times alloc_skb called: 1,226,594             1,213,327
