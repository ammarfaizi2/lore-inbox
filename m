Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUD2UYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUD2UYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 16:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264963AbUD2UYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:24:19 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47075 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S264960AbUD2UYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:24:13 -0400
Date: Thu, 29 Apr 2004 13:24:13 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: Ross Dickson <ross@datscreative.com.au>
Cc: Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Message-ID: <20040429202413.GA1982@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	Ross Dickson <ross@datscreative.com.au>,
	Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl,
	"Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
	Craig Bradney <cbradney@zip.com.au>,
	christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Jamie Lokier <jamie@shareable.org>,
	Daniel Drake <dan@reactivated.net>, Ian Kumlien <pomac@vapor.com>,
	Allen Martin <AMartin@nvidia.com>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl> <200404282133.34887.ross@datscreative.com.au> <20040428205938.GA1995@tesore.local> <200404292144.37479.ross@datscreative.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404292144.37479.ross@datscreative.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 09:44:37PM +1000, Ross Dickson wrote:
> On Thursday 29 April 2004 06:59, Jesse Allen wrote:
> > almost in unison with the sound coming from the computer.  Maybe the IDE or 
> > hard drive is related, but it is too much related to C1 disconnect.
> 
> I think I might break out my oscilloscope this weekend and have a look at how 
> clean the supply rails are around the cpu and northbridge and southbridge. 
> Who knows I might get lucky and see some unexpected ripple or spikes.

I'd be interested in knowing the results.

> > resonance can break systems.  But to think that my board is doing emmitting 
> > noise like that is pretty bizarre.
> 
> Not as bizarre as you may think. I have heard coils and even capacitors "sing"
> in years past whilst servicing electronics.

Yes, I know that these things can theorectically happen.  But when it happens
to me, it's a suprise.  To an electronics genius, he probably encounters it 
more often. =)

> > C1 handshake time?  Isn't that much like what your patch does?
> 
> I had not really thought about it from that perspective. Whilst my patch cannot 
> alter the handshake times it does prevent consecutive C1 cycles from occurring
> too close together. Too close together I think being less than about 800ns. I 

ah, ok.

> guess I could look at that with a cro too - use an appropriate pin as the 
> trigger source and see if supply rails have load dump voltage rises when 
> going into disconnect. Maybe rail voltage rings for about 700ns and might be 
> out of tolerence inside Athlon during that time. Would be very interesting if
> a few hundred picofarad of low esr decoupling cap placed on a supply rail 
> near a chip makes a difference? A pinout of the nforce2 chipset would help a 
> great deal here but I do not have one. Can anyone oblige me?


What I'd like to know is where the sound chip is really at on my board.  I've 
tried looking before, but find myself confused.

A pic:
http://us.shuttle.com/images/productimages/AN35.jpg

According to a diagram that I have, it points to an AC'97 6-CH AUDIO as a chip
near of the top of the board in the image that I link to, above 2nd PCI slot 
left of the AGP.  But I'm am also left thinking, how does the NForce2 MCP come 
into play.  Specs would help.  Maybe if we can figure out how the sound is 
wired on the board, we could also trace the source of noise to the exact 
component.

Jesse
