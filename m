Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262516AbREUWWr>; Mon, 21 May 2001 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbREUWWc>; Mon, 21 May 2001 18:22:32 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:63760 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S262511AbREUWWK>; Mon, 21 May 2001 18:22:10 -0400
Date: Tue, 22 May 2001 00:22:27 +0200
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        Andrew Morton <andrewm@uow.edu.au>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: alpha iommu fixes
Message-ID: <20010522002227.D8020@suse.de>
In-Reply-To: <15112.26868.5999.368209@pizda.ninka.net> <20010521034726.G30738@athlon.random> <15112.48708.639090.348990@pizda.ninka.net> <20010521105944.H30738@athlon.random> <15112.55709.565823.676709@pizda.ninka.net> <20010521112357.A1718@gruyere.muc.suse.de> <15112.57377.723591.710628@pizda.ninka.net> <20010521114216.A1968@gruyere.muc.suse.de> <15112.59192.613218.796909@pizda.ninka.net> <20010521122753.A2507@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010521122753.A2507@gruyere.muc.suse.de>; from ak@suse.de on Mon, May 21, 2001 at 12:27:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21 2001, Andi Kleen wrote:
> On Mon, May 21, 2001 at 03:00:24AM -0700, David S. Miller wrote:
> >  > That's currently the case, but at least on IA32 the block layer
> >  > must be fixed soon because it's a serious performance problem in
> >  > some cases (and fixing it is not very hard).
> > 
> > If such a far reaching change goes into 2.4.x, I would probably
> > begin looking at enhancing the PCI dma interfaces as needed ;-)
> 
> Hmm, I don't think it'll be a far reaching change. As far as I can see 
> all it needs is a new entry point for block device drivers that uses 
> bh->b_page. When that entry point exists skip the create_bounce call 
> in __make_request. After that it is purely problem for selected drivers.

I've already done it, however not as a 2.4 solution. The partial and WIP
patches is here:

*.kernel.org/pub/linux/kernel/people/axboe/v2.5/bio-7

Block driver can indicate the need for bounce buffers above a certain
page.

Of course I can hack up something for 2.4 as well, but is this really a
pressing need?

-- 
Jens Axboe

