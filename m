Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310591AbSCMNwE>; Wed, 13 Mar 2002 08:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310595AbSCMNvy>; Wed, 13 Mar 2002 08:51:54 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:33542 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310591AbSCMNvu>;
	Wed, 13 Mar 2002 08:51:50 -0500
Date: Wed, 13 Mar 2002 10:51:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>, <wli@holomorphy.com>,
        <wli@parcelfarce.linux.theplanet.co.uk>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <phillips@bonn-fries.net>
Subject: Re: 2.4.19pre2aa1
In-Reply-To: <20020313115713.E1703@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203131050440.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Andrea Arcangeli wrote:
> On Wed, Mar 13, 2002 at 08:30:55AM +0100, Andrea Arcangeli wrote:
> >  {
> >  	clear_bit(BH_Wait_IO, &bh->b_state);
> >  	clear_bit(BH_Lock, &bh->b_state);
> > +	clear_bit(BH_Launder, &bh->b_state);
> >  	smp_mb__after_clear_bit();
> >  	if (waitqueue_active(&bh->b_wait))
>
> actually, while refining the patch and integrating it, I audited it some
> more carefully and the above was wrong,

It's complex.

Would there be a way to simplify the thing so the author
of the code can at least get it right and there's a chance
of other people understanding it too ? ;)

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

