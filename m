Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279470AbRKASWL>; Thu, 1 Nov 2001 13:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279473AbRKASWC>; Thu, 1 Nov 2001 13:22:02 -0500
Received: from ns.suse.de ([213.95.15.193]:42503 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279470AbRKASVy>;
	Thu, 1 Nov 2001 13:21:54 -0500
Date: Thu, 1 Nov 2001 19:21:53 +0100
From: Andi Kleen <ak@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: Andi Kleen <ak@suse.de>, joris@deadlock.et.tudelft.nl,
        linux-kernel@vger.kernel.org
Subject: Re: Bind to protocol with AF_PACKET doesn't work for outgoing packets
Message-ID: <20011101192153.A30903@wotan.suse.de>
In-Reply-To: <20011101184511.A22234@wotan.suse.de> <200111011809.VAA26876@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <200111011809.VAA26876@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Thu, Nov 01, 2001 at 09:09:07PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 09:09:07PM +0300, A.N.Kuznetsov wrote:
> > ugly imho; if the feature exists it should be implemented for the full
> > packet functionality which includes binding to protocols.
> 
> This is a silly abuse. Sniffers do not bind to protocols, should not
> do this and have no reasons to do this.

When you e.g. have a TCP sniffer it makes sense to only bind it to ETH_P_IP.

If the sll_protocol field is not fully supported it should be removed.

> 
> 
> >  I think the patch should be added.
> 
> That which adds all the packet sockets to ptype_all? Do you jest? :-)

Do you worry about the handling of hundreds of packet sockets? 

Using the ptype hash before was nice, but does not look like it is absolutely
required. The overhead this way is not much bigger for a reasonable number
of packet sockets (and for a large number the current ptype hash is likely 
inadequate anyways) 


-Andi
