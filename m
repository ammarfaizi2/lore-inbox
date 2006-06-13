Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWFMX7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWFMX7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWFMX7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:59:48 -0400
Received: from relay02.pair.com ([209.68.5.16]:35343 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S932368AbWFMX7q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:59:46 -0400
X-pair-Authenticated: 71.197.50.189
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: bidulock@openss7.org
Subject: Re: [RFC/PATCH 1/2] in-kernel sockets API
Date: Tue, 13 Jun 2006 18:59:21 -0500
User-Agent: KMail/1.9.3
Cc: Daniel Phillips <phillips@google.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       Sridhar Samudrala <sri@us.ibm.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <1150156562.19929.32.camel@w-sridhar2.beaverton.ibm.com> <448F3C83.9080606@google.com> <20060613164714.B7232@openss7.org>
In-Reply-To: <20060613164714.B7232@openss7.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200606131859.43695.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 17:46, Brian F. G. Bidulock wrote:
> Daniel,
>
> On Tue, 13 Jun 2006, Daniel Phillips wrote:
> > You probably meant "non-GPL-compatible non-proprietary".  If so, then by
> > definition there are none.
>
> Well, being GPL compatible is not a requirement for an open source license.
>
> IANAL, but last I checked, pure-BSD is not compatible with GPL (it actually
> has to be dual-licensed BSD/GPL).

It depends on what you mean by "pure-BSD". If you're talking about the 
4-clause license with the advertising clause, then you are correct. Otherwise 
(IANAL) but my understanding is that BSD code can even be relicensed GPL by a 
third party contribution (though it is perhaps kind to ask for relicensing 
permission anyway).

>From your other message:

> To some it is a serious failing of Linux (particularly those involved in
> porting kernel modules from branded UNIX or embedded RTOS).  To those
> whatever stability that can be offered is a boon.  To those, even worse is
> the lack of an ABI (even for a single kernel version).   

Then would offering a 'stable API in disguise' not be a disaster and an 
irritation to these people? If the kernel doesn't specify that an in-kernel 
interface is stable, then there is no reason to expect it to be. It might not 
change, but there won't be too much sympathy for out-of-tree users if it 
does. The kernel comes with big warnings about the lack of a stable API for a 
reason.

> Another thing to consider is that the first step for many organizations in
> opening a driver under GPL is to release a proprietary module that at least
> first works.  

If the driver is an old-tech Linux port, then it seems there isn't too much 
stopping them from doing this today (aside from the fact that some people 
think proprietary modules are murky anyway). In this case, we don't want a 
stable API/ABI, because then we leave them with little incentive to open the 
code.

And if the driver is new code, they're better off doing an open driver from 
the start (especially since writing a driver _for_ Linux, as opposed to 
porting one, might make it count as 'derived' and hence unlawful unless 
released GPL).

> Sorry for the rant.

We're not as perfect as I wish we were. But the lack of stable API (dead 
horse) is something that is fairly well established and understood. I think 
most people feel that the cost-benefit analysis, for Linux anyway, strongly 
favors no stable API.

Thanks,
Chase
