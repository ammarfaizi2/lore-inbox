Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131324AbRDJSYs>; Tue, 10 Apr 2001 14:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131346AbRDJSYi>; Tue, 10 Apr 2001 14:24:38 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:27914 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131324AbRDJSYX>;
	Tue, 10 Apr 2001 14:24:23 -0400
Date: Tue, 10 Apr 2001 20:24:16 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        David Schleef <ds@schleef.org>, Mark Salisbury <mbs@mc.com>,
        Jeff Dike <jdike@karaya.com>, schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: No 100 HZ timer !
Message-ID: <20010410202416.A21512@pcep-jamie.cern.ch>
In-Reply-To: <20010410193521.A21133@pcep-jamie.cern.ch> <E14n2hi-0004ma-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14n2hi-0004ma-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Apr 10, 2001 at 07:17:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > > This is an X issue. I was talking with Jim Gettys about what is needed to
> > > get the relevant existing X extensions for this working
> > 
> > Last time I looked at XF86DGA (years ago), it seemed to have the right
> > hooks in place.  Just a matter of server implementation.  My
> > recollection is dusty though.
> 
> There is also a timing extension for synchronizing events to happenings. The
> stopper is the kernel interface for the vblank handling since the irq must
> be handled and cleared in kernel context before we return to X. We now think
> we know how to handle that cleanly

Except for cards which don't generate an irq on vsync but do let you see
how the raster is proceeding.  (I vaguely recall these).  For which a
PLL and, wait for it.... high resolution timer is needed.

Perhaps that's a 1990s problem that doesn't need a 2000s solution though :-)

-- Jamie
