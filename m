Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272561AbRIFUa6>; Thu, 6 Sep 2001 16:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272559AbRIFUas>; Thu, 6 Sep 2001 16:30:48 -0400
Received: from ns.suse.de ([213.95.15.193]:44556 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S272558AbRIFUao>;
	Thu, 6 Sep 2001 16:30:44 -0400
Date: Thu, 6 Sep 2001 22:31:03 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Wietse Venema <wietse@porcupine.org>,
        Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
Message-ID: <20010906223103.A13300@gruyere.muc.suse.de>
In-Reply-To: <20010906221152.F13547@emma1.emma.line.org> <E15f5gd-0000Pu-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15f5gd-0000Pu-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Sep 06, 2001 at 09:23:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2001 at 09:23:43PM +0100, Alan Cox wrote:
> > Alan, SIOCGIFCONF is working sufficiently, it's SIOCGIFNETMASK that
> > we're talking about. SIOCGIFNETMASK works properly on any other system
> > or - as far as I can currently test - with my patch.
> 
> Then that is worth looking into.

First it would break lots of linux user land (which doesn't initialise sin_addr
in SIOCGIFNETMASK) and special casing for "local networks" is in any case bogus.
Netmask checking is only needed for that; it's not even needed for local address
checking.

-Andi
