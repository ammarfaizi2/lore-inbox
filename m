Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVDSIY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVDSIY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 04:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVDSIY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 04:24:26 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:13397 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261410AbVDSIYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 04:24:23 -0400
Subject: Re: E1000 - page allocation failure - saga continues :(
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4264BE1F.50508@univ-nantes.fr>
References: <20050414214828.GB9591@mail.muni.cz>
	 <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz>
	 <4264B202.9080304@univ-nantes.fr>
	 <1113897810.5074.66.camel@npiggin-nld.site> <4264BE1F.50508@univ-nantes.fr>
Content-Type: text/plain; charset=utf-8
Date: Tue, 19 Apr 2005 18:24:19 +1000
Message-Id: <1113899059.5074.71.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-19 at 10:15 +0200, Yann Dupont wrote:
> Nick Piggin a écrit :
> 
> >
> >>Do you have turned NAPI on ??? I tried without it off on e1000 and ...
> >>surprise !
> >>Don't have any messages since 12H now (usually I got those in less than 1H)
> >>
> >>    
> >>
> >
> >Possibly kswapd might be unable to get enough CPU to free memory.
> >
> >  
> >
> Ok, so what you're saying is that turning NAPI off is just slowing down
> things enough to not be hit by
> this problem , right ?
> 

Perhaps, yes. Or that NAPI is using more CPU than non-NAPI
(which I understand can happen in some corner cases).

If you have a multiprocessor (or even hyperthreading), I
think you could test this by binding kswapd on cpu CPU, and
put nic interrupts on the other - then test with and without
NAPI.

That is, presuming you can reproduce the problem on your
multiprocessor system in the first place.


-- 
SUSE Labs, Novell Inc.


