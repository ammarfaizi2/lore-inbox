Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUECUpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUECUpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUECUpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:45:40 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:10125 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S263971AbUECUpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:45:32 -0400
Date: Mon, 3 May 2004 13:45:20 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Ross Dickson <ross@datscreative.com.au>, Len Brown <len.brown@intel.com>,
       a.verweij@student.tudelft.nl, Craig Bradney <cbradney@zip.com.au>,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Message-ID: <20040503204520.GA1994@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	"Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
	Ross Dickson <ross@datscreative.com.au>,
	Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl,
	Craig Bradney <cbradney@zip.com.au>,
	christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Jamie Lokier <jamie@shareable.org>,
	Daniel Drake <dan@reactivated.net>, Ian Kumlien <pomac@vapor.com>,
	Allen Martin <AMartin@nvidia.com>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl> <200404282133.34887.ross@datscreative.com.au> <20040428205938.GA1995@tesore.local> <200404292144.37479.ross@datscreative.com.au> <20040429202413.GA1982@tesore.local> <40916638.2040202@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40916638.2040202@gmx.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 10:31:52PM +0200, Prakash K. Cheemplavam wrote:
> Jesse Allen wrote:
> >What I'd like to know is where the sound chip is really at on my board.  
> 
> Yes, I also think the chip above 2nd PCI slot is the right one. You can 
> see the realtek logo. It is only a ac97 codec (basically not more than a 
> DAC and ADC) and linux currently only has drivers for this. The MCP-T 
> has an APU, which could do dsp stuff by hardware, but no drivers still 
> (Hello Nvidia?), so all of this is done via software. (THe APU has even 
> more functionality, like DD5.1 realtime encoding, fx, and whatever). In 
> our case, the APU shouldn't cause any troubles, as it is not used. With 
> the APU, nforce2 chipset behaves like a "real" soundcard. Without, its 
> sound abilities are not better than the average mainboard's onboard sound.
> 
> Prakash
> 

Thanks.  I've also got some one reporting to me of having the same problem
with the Asus A7N8X board.  Also note, that I don't have the intel8x0 loaded
and it will still do it.  I can even disable the onboard sound in BIOS and it
will _still_ have the sound on the speaker out.  Want to know how the sound 
varies?  Try compiling a linux kernel.  Between executing make processes the sound will vary alot (from nothing to the annoying pitch).  The sound is quite 
faint to probably be heard on speakers, but on headphones you probably will 
hear it.  To me, this is indicative of the C1 disconnects.

Jesse

