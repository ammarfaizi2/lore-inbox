Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVBMTBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVBMTBr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 14:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVBMTBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 14:01:46 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:3012 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261292AbVBMTBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 14:01:44 -0500
Date: Sun, 13 Feb 2005 20:02:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Kenan Esau <kenan.esau@conan.de>
Cc: harald.hoyer@redhat.de, lifebook@conan.de, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Message-ID: <20050213190216.GA4147@ucw.cz>
References: <20050211201013.GA6937@ucw.cz> <1108227679.12327.24.camel@localhost> <20050212183440.GC8170@ucw.cz> <1108289100.5978.18.camel@localhost> <20050213120100.GB1978@ucw.cz> <1108318484.5978.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108318484.5978.25.camel@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 13, 2005 at 07:14:44PM +0100, Kenan Esau wrote:
> Am Sonntag, den 13.02.2005, 13:01 +0100 schrieb Vojtech Pavlik: 
> > On Sun, Feb 13, 2005 at 11:05:00AM +0100, Kenan Esau wrote:
> >  
> > > > > This
> > > > > sequence does not always work and there is not something like a "magic
> > > > > knock sequence".
> > > > 
> > > > You mean that the only needed bit is setting the resolution to '7'?
> > > 
> > > The lifebook touchscreen has some extensions to the standard protocol:
> > > 
> > > 0xe8 0x06: Stop absolute coordinate output 
> > > 0xe8 0x07: Start absolute coordinate outpout (3-byte packets)
> > > 0xe8 0x08: Start absolute coord. output with 6-byte packets
> > 
> > Are the 6-byte packets carrying any more information than the 3-byte
> > packets do, for example pressure? Would it be useful to go for the
> > 6-byte mode instead in the driver?
> 
> No the 6-byte mode does not carry any more information. Sorry but no
> pressure-info... 

I wonder what it's good for then - there must be a reason.

> > Have you tried whether the controller responds to the GETID (f2),
> > GETINFO (e9) and POLL (eb) commands? Maybe we could detect it that way.
> 
> I have to try those commands and check the response. I know that they
> are supported but I have never tried them.
> 
> [...]
> 
> > > If you agree I will take your patch as the basis and make it work. Now I
> > > know how you want it to look like.
> > 
> > That would be very much appreciated.
> 
> OK. I'll send you a new patch within the next week.

Thanks.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
