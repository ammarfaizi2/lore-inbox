Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271365AbRIFQrq>; Thu, 6 Sep 2001 12:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271413AbRIFQrg>; Thu, 6 Sep 2001 12:47:36 -0400
Received: from ns.suse.de ([213.95.15.193]:17416 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271365AbRIFQr1>;
	Thu, 6 Sep 2001 12:47:27 -0400
Date: Thu, 6 Sep 2001 18:47:42 +0200
From: Andi Kleen <ak@suse.de>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Wietse Venema <wietse@porcupine.org>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
Message-ID: <20010906184742.A10228@gruyere.muc.suse.de>
In-Reply-To: <20010906193750.B22187@castle.nmd.msu.ru> <20010906155811.BC78DBC06C@spike.porcupine.org> <20010906204423.B23109@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010906204423.B23109@castle.nmd.msu.ru>; from saw@saw.sw.com.sg on Thu, Sep 06, 2001 at 08:44:23PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 08:44:23PM +0400, Andrey Savochkin wrote:
> The question was which ip.address in user@[ip.address] should be treated as
> local.
> My comment was that the only reasonable solution on Linux is to treat this
> way addresses explicitly specified in the configuration file.
> Postfix may show its guess at the installation time.
> 
> Now the question of recognizing user@[ip.address] as local is a question of a
> simple table lookup.

It would be at least possible to ask the routing engine via RTM_GETROUTE
and checking for RTN_LOCAL if it considers an address local.
It won't cover all cases with netfilter rules etc.; but probably be a good
enough approximation.

-Andi
