Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291701AbSBXWkB>; Sun, 24 Feb 2002 17:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291700AbSBXWjv>; Sun, 24 Feb 2002 17:39:51 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:19461 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291693AbSBXWjk>; Sun, 24 Feb 2002 17:39:40 -0500
Date: Sun, 24 Feb 2002 23:39:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Paul Mackerras <paulus@samba.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Troy Benjegerdes <hozer@drgw.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224233937.B2257@ucw.cz>
In-Reply-To: <Pine.LNX.4.10.10202232136560.5715-100000@master.linux-ide.org> <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com> <20020224013038.G10251@altus.drgw.net> <3C78DA19.4020401@evision-ventures.com> <20020224142902.C1682@altus.drgw.net> <20020224215422.B1706@ucw.cz> <15481.25250.869765.860828@argo.ozlabs.ibm.com> <20020224231002.B2199@ucw.cz> <15481.26697.420856.1109@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15481.26697.420856.1109@argo.ozlabs.ibm.com>; from paulus@samba.org on Mon, Feb 25, 2002 at 09:25:13AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 09:25:13AM +1100, Paul Mackerras wrote:

> Vojtech Pavlik writes:
> > On Mon, Feb 25, 2002 at 09:01:06AM +1100, Paul Mackerras wrote:
> > > We have some RS/6000 machines that have two separate PCI buses (two
> > > host bridges) that run at 33MHz and 50MHz respectively.  Fortunately
> > > we also get a device tree from the firmware that tells us this.
> > 
> > I really wonder why the 50 MHz one doesn't run at 66 MHz, and what
> 
> Apparently the rationale is that you can put more slots on the bus
> if you run it at 50MHz than you can at 66MHz.

I see. That makes sense.

> > happens if you plug in a 66MHz non-capable card to the 50 MHz bus.
> 
> The bus speed drops to 33MHz.

Interesting. I'd expect 25 myself ... then we'll definitely need two
clock values in struct pci_bus - because the hi-speed one isn't always a
double the low one - as shown by your example.

-- 
Vojtech Pavlik
SuSE Labs
