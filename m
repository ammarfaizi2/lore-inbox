Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268418AbRG3Hlj>; Mon, 30 Jul 2001 03:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268416AbRG3Hl2>; Mon, 30 Jul 2001 03:41:28 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:59595 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268418AbRG3HlX>; Mon, 30 Jul 2001 03:41:23 -0400
Date: Mon, 30 Jul 2001 00:40:43 -0700 (PDT)
From: Sridhar Samudrala <samudrala@us.ibm.com>
To: kuznet@ms2.inr.ac.ru
cc: Thiemo Voigt <thiemo@sics.se>, dmfreim@us.ibm.com,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org, lartc@mailman.ds9a.nl,
        diffserv-general@lists.sourceforge.net, rusty@rustcorp.com.au
Subject: Re: [PATCH] Inbound Connection Control mechanism: Prioritized Accept
In-Reply-To: <200107291625.UAA16491@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.21.0107300035490.22748-100000@w-sridhar2.des.sequent.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 29 Jul 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
> 
> > The aim of TCP SYN policing is to prevent server overload by discarding
> > connection requests
> 
> Well, I alluded to this particularly. :-)
> 
> But if Sridhar meaned this saying about SYN policing, I would
> prefer this, rather than bare prioritization, which is pretty
> dubious when taken alone.

Alexey,

Yes. I also meant that in kernel prioritization of connections needs to be 
complemented with SYN policing so that starvation of a particular class of
connections is avoided. We do mention this in our HOWTO for our patch. 

I also agree with your suggestion that an enhancement to our patch can be
to reserve some slots for each class based on the priority and drop lower
priority connections even when accept queue is not full. 
I am not sure how much overhead is involved in maintaining the the no. of
slots left for each priority class. Also what should be the ratio of slots 
that need to reserved for each class? 

Do you think that the existing PAQ patch with SYN policing is a reasonable
way for prioritizing incoming connection requests? Or will it be worthwhile
to enhance our patch to add dropping of connections based on priority. 
Preempting existing low priority connections in acceptq with high priority 
ones may not be good idea as we need to abort them by sending a RST.

Thanks
Sridhar
> 
> Alexey
> 

