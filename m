Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266957AbSKQWza>; Sun, 17 Nov 2002 17:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbSKQWza>; Sun, 17 Nov 2002 17:55:30 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:7299 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266957AbSKQWz3>;
	Sun, 17 Nov 2002 17:55:29 -0500
Date: Sun, 17 Nov 2002 18:05:38 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Justin A <ja6447@albany.edu>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: pnpbios oops on boot w/ 2.5.47
Message-ID: <20021117180538.GC1273@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Justin A <ja6447@albany.edu>, linux-kernel@vger.kernel.org,
	greg@kroah.com
References: <200211161700.29653.ja6447@albany.edu> <3DD6F655.4214A594@digeo.com> <20021116232528.GA1273@neo.rr.com> <200211170100.53986.ja6447@albany.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211170100.53986.ja6447@albany.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 01:00:53AM -0500, Justin A wrote:
> On Saturday 16 November 2002 06:25 pm, Adam Belay wrote:
> 
> > Oops.  I put the pnpbios_kmalloc in the wrong place.  It's amazing it still
> > worked on my test box.  Here's a patch that should fix it.  Justin: could
> > you please try it.
> >
> > Thanks,
> > Adam
> I had a fealing that call_pnp_bios was doing something with data so I tried it 

> anyway with:
> 
> CONFIG_PNP=y
> CONFIG_PNP_NAMES=y
> CONFIG_PNP_DEBUG=y
> CONFIG_ISAPNP=y
> CONFIG_PNPBIOS=y
> 
> and it booted ok.  You were right, it was a serial port(even though that port 
> always worked without pnp:))
> 
> I didn't have NAMES and DEBUG on before, so hopefully neither of those is what 

> fixed it in this case.
> 
> Here is the new dmseg, you can ignore the crap at the end, thats just pcmcia
> being broken, it goes away if I move /l/m/2/k/d/pcmcia out of the way.
>
> --
> -Justin


> pnp: the driver 'serial' has been registered
> pnp: pnp: match found with the PnP device '00:13' and the driver 'serial'
> pnp: the device '00:13' has been activated
> PnPBIOS: set_dev_node: Unexpected status 0x85

Hmm, this isn't right.  0x85 means unable to set resources.  If you have it 
could you please send me a copy of the output of lspnp for node 13.  I'm not
sure what this device is, do you have a second serial port?

Thanks,
Adam
