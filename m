Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291775AbSBXXDC>; Sun, 24 Feb 2002 18:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291774AbSBXXCn>; Sun, 24 Feb 2002 18:02:43 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:32261 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291773AbSBXXCe>; Sun, 24 Feb 2002 18:02:34 -0500
Date: Mon, 25 Feb 2002 00:02:31 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, "David S. Miller" <davem@redhat.com>,
        paulus@samba.org, dalecki@evision-ventures.com, torvalds@transmeta.com,
        andre@linuxdiskcert.org, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020225000231.B2590@ucw.cz>
In-Reply-To: <20020224231002.B2199@ucw.cz> <15481.26697.420856.1109@argo.ozlabs.ibm.com> <20020224233937.B2257@ucw.cz> <20020224.144423.104049454.davem@redhat.com> <20020224235113.B2412@ucw.cz> <20020224165937.I1682@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020224165937.I1682@altus.drgw.net>; from hozer@drgw.net on Sun, Feb 24, 2002 at 04:59:37PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 04:59:37PM -0600, Troy Benjegerdes wrote:
> On Sun, Feb 24, 2002 at 11:51:13PM +0100, Vojtech Pavlik wrote:
> > On Sun, Feb 24, 2002 at 02:44:23PM -0800, David S. Miller wrote:
> > 
> > >    From: Vojtech Pavlik <vojtech@suse.cz>
> > >    Date: Sun, 24 Feb 2002 23:39:37 +0100
> > >    
> > >    > > happens if you plug in a 66MHz non-capable card to the 50 MHz bus.
> > >    > 
> > >    > The bus speed drops to 33MHz.
> > >    
> > >    Interesting. I'd expect 25 myself ... then we'll definitely need two
> > >    clock values in struct pci_bus - because the hi-speed one isn't always a
> > >    double the low one - as shown by your example.
> > > 
> > > You only need one, the current active one.
> > >
> > > If you think that hot-plug is an issue, the arch dependant could would
> > > need to recalculate the "current bus speed" and all would be fine.
> > > 
> > > So why do we need two values?
> > 
> > Oh, you're right. We indeed need only one.
> > 
> > Hmm, now hotplug changing the PCI clock would be quite a lot of fun -
> > all running drivers will need to know about the change, because some may
> > need to recompute the timings they have programmed into the chips ...
> > 
> > Because virtually disconnecting and reconnecting all the cards for which
> > the timings have changed will probably not be an option.
> 
> Personally, I think hot-plugging a 33mhz pci device into a 66mhz pci bus 
> with other active devices on it is either user error or designer error 
> (should have had a bridge), and a 'virtual disconnect and reconnect' is 
> reasonable. 
> 
> You're going to kill (or at least stop) any transactions going on on the
> bus while you're physically hot-plugging anway..

I'd guess most hotpluggable PCIs will have a bridge per slot ...
hopefully.

-- 
Vojtech Pavlik
SuSE Labs
