Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265583AbTF2GMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 02:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTF2GMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 02:12:42 -0400
Received: from netcore.fi ([193.94.160.1]:64011 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id S265583AbTF2GMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 02:12:40 -0400
Date: Sun, 29 Jun 2003 09:26:55 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Michael Bellion and Thomas Heinz <nf@hipac.org>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
In-Reply-To: <3EFDF4DA.80201@hipac.org>
Message-ID: <Pine.LNX.4.44.0306290924310.28882-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 28 Jun 2003, Michael Bellion and Thomas Heinz wrote:
> You wrote:
> > Looks interesting.  Is there experience about this in bridging firewall 
> > scenarios? (With or without external patchset's like 
> > http://ebtables.sourceforge.net/)
> 
> Sorry for this answer being so late but we wanted to check whether
> nf-hipac works with the ebtables patch first in order to give you
> a definite answer. We tried on a sparc64 which was a bad decision
> because the ebtables patch does not work on sparc64 systems.
> We are going to test the stuff tomorrow on an i386 and tell you
> the results afterwards.
> 
> In principle, nf-hipac should work properly whith the bridge patch.
> We expect it to work just like iptables apart from the fact that
> you cannot match on bridge ports. The iptables' in/out interface
> match in 2.4 works the way that it matches if either in/out dev
> _or_ in/out physdev. The nf-hipac in/out interface match matches
> solely on in/out dev.

Thanks for this information.
 
> > Further, you mention the performance reasons for this approach.  I would 
> > be very interested to see some figures.
> 
> We have done some performance tests with an older release of nf-hipac.
> The results are available on http://www.hipac.org/
> 
> Apart from that Roberto Nibali did some preliminary testing on nf-hipac.
> You can find his posting to linux-kernel here: 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103358029605079&w=2
> 
> Since there are currently no performance tests available for the
> new release we want to encourage people interested in firewall
> performance evaluation to include nf-hipac in their tests.

Yes, I had missed this when I quickly looked at the web page using lynx. 
Thanks.

One obvious thing that's missing in your performance and Roberto's figures 
is what *exactly* are the non-matching rules.  Ie. do they only match IP 
address, a TCP port, or what? (TCP port matching is about a degree of 
complexity more expensive with iptables, I recall.)

-- 
Pekka Savola                 "You each name yourselves king, yet the
Netcore Oy                    kingdom bleeds."
Systems. Networks. Security. -- George R.R. Martin: A Clash of Kings

