Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281424AbRKMBam>; Mon, 12 Nov 2001 20:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281425AbRKMBad>; Mon, 12 Nov 2001 20:30:33 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48889
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281424AbRKMBaW>; Mon, 12 Nov 2001 20:30:22 -0500
Date: Mon, 12 Nov 2001 17:30:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "David S. Miller" <davem@redhat.com>, helgehaf@idb.hist.no,
        linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011112173014.G32099@mikef-linux.matchmail.com>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	"David S. Miller" <davem@redhat.com>, helgehaf@idb.hist.no,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011112.152304.39155908.davem@redhat.com> <E163QHW-0007gY-00@wagner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E163QHW-0007gY-00@wagner>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 10:14:22AM +1100, Rusty Russell wrote:
> In message <20011112.152304.39155908.davem@redhat.com> you write:
> >    From: Rusty Russell <rusty@rustcorp.com.au>
> >    Date: Mon, 12 Nov 2001 20:59:05 +1100
> > 
> >    (atomic_inc & atomic_dec_and_test for every packet, anyone?).
> > 
> > We already do pay that price, in skb_release_data() :-)
> 
> Sorry, I wasn't clear!  skb_release_data() does an atomic ops on the
> skb data region, which is almost certainly on the same CPU.  This is
> an atomic op on a global counter for the module, which almost
> certainly isn't.
> 
> For something which (statistically speaking) never happens (module
> unload).
>

Is this in the fast path or slow path?

If it only happens on (un)load, then there isn't any cost until it's needed...

Mike
