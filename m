Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVDZOhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVDZOhn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVDZOhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:37:43 -0400
Received: from post.arx.com ([212.25.66.95]:37958 "EHLO post.arx.com")
	by vger.kernel.org with ESMTP id S261411AbVDZOhf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:37:35 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Re-routing packets via netfilter (ip_rt_bug)
X-Mimeole: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 26 Apr 2005 17:39:31 +0200
Message-ID: <4151C0F9B9C25C47B3328922A6297A3286CFA9@post.arx.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re-routing packets via netfilter (ip_rt_bug)
Thread-Index: AcVKATCdrAz8cyfbSYS32kx8Bpg6oQAdLglg
From: "Yair Itzhaki" <Yair@arx.com>
To: "Herbert Xu" <herbert@gondor.apana.org.au>,
       "Patrick McHardy" <kaber@trash.net>
Cc: <linux-kernel@vger.kernel.org>, <netfilter-devel@lists.netfilter.org>,
       <netdev@oss.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm afraid I'm not following you.
Where did you want to set saddr=0 ?

Yair


> -----Original Message-----
> From: Herbert Xu [mailto:herbert@gondor.apana.org.au]
> Sent: Tuesday, April 26, 2005 02:39
> To: Patrick McHardy
> Cc: Yair Itzhaki; linux-kernel@vger.kernel.org; 
> netfilter-devel@lists.netfilter.org; netdev@oss.sgi.com
> Subject: Re: Re-routing packets via netfilter (ip_rt_bug)
> 
> 
> On Tue, Apr 26, 2005 at 02:08:18AM +0200, Patrick McHardy wrote:
> > Herbert Xu wrote:
> > >You're right.  But then we can't call ip_route_output in the case
> > >where saddr is foreign but daddr is local.  Nor can we call
> > >ip_route_input since the output will be ip_rt_bug.
> > 
> > In that case we need to use saddr=0, which shouldn't make 
> any difference
> > with sane routing.
> 
> Makes sense.  But what about the case where saddr is foreign but
> daddr is broadcast/multicast?
> 
> Cheers,
> -- 
> Visit Openswan at http://www.openswan.org/
> Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 
