Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSFCUOW>; Mon, 3 Jun 2002 16:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSFCUOV>; Mon, 3 Jun 2002 16:14:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48655 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315480AbSFCUOM>;
	Mon, 3 Jun 2002 16:14:12 -0400
Message-ID: <3CFBCDBD.DF675D57@zip.com.au>
Date: Mon, 03 Jun 2002 13:12:45 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john slee <indigoid@higherplane.net>
CC: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
        Helge Hafting <helgehaf@aitel.hist.no>,
        "Ronny T. Lampert (EED)" <Ronny.Lampert@eed.ericsson.se>,
        linux-kernel@vger.kernel.org
Subject: Re: 3c59x driver: card not responding after a while
In-Reply-To: <3CFB21C5.27BBFB66@aitel.hist.no> <Pine.LNX.4.44.0206031050170.10836-100000@netfinity.realnet.co.sz> <20020603125752.GE12322@higherplane.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john slee wrote:
> 
> On Mon, Jun 03, 2002 at 10:51:34AM +0200, Zwane Mwaikambo wrote:
> > On Mon, 3 Jun 2002, Helge Hafting wrote:
> >
> > > I see this too.  I always thought it was the less-than-perfect ABIT BP6
> > > loosing an irq or something.  (odd that it _always_ is the NIC that goes
> > > though...)  I also have a k6 with the same NIC, and another
> > > UP machine at work.  They never fail this way.
> > > Could it be a SMP problem?
> >
> > I wouldn't think so, i use it on SMP extensively without a hitch.
> 
> "me too" - have been using 3c905B cards in various SMP (and UP) boxes
> for a couple of years now and they've never failed me, even on bp6.  in
> fact i seem to have missed out on the plague of bp6 problems, even when
> running dual 300a overclocked to 450.  strange.
> 

That driver is solid for SMP.  It's possible that the BP6
is losing its IRQ routing assignments, or the APIC is
getting stuck.  We had extensive problems with that last
year.  A workaround was implemented and as far as I can tell,
the problem went away.

It seems to affect network cards most because they typically
generate the most interrupts.

Try booting the machine with the `noapic' option.

-
