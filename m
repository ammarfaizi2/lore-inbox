Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271309AbRIFQBl>; Thu, 6 Sep 2001 12:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271332AbRIFQBV>; Thu, 6 Sep 2001 12:01:21 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:64006 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271309AbRIFQBN>; Thu, 6 Sep 2001 12:01:13 -0400
Date: Thu, 6 Sep 2001 18:01:30 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: Matthias Andree <matthias.andree@gmx.de>,
        Wietse Venema <wietse@porcupine.org>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19]
Message-ID: <20010906180130.H29583@maggie.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Andrey Savochkin <saw@saw.sw.com.sg>,
	Wietse Venema <wietse@porcupine.org>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010906173534.A21874@castle.nmd.msu.ru> <20010906140444.75DC1BC06C@spike.porcupine.org> <20010906162124.D29583@maggie.dt.e-technik.uni-dortmund.de> <20010906193750.B22187@castle.nmd.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010906193750.B22187@castle.nmd.msu.ru>; from saw@saw.sw.com.sg on Thu, Sep 06, 2001 at 19:37:50 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Sep 2001, Andrey Savochkin wrote:

> Of course, SIOCGIFCONF isn't even close to provide the list of local
> addresses.
> Obvious example: it doesn't enlist all addresses 127.0.0.1, 127.0.0.2 etc.
> on common systems.  If you handle 127.0.0.2 as local, you apply side
> knowledge about properties of loopback interface.

Well, 127.0.0.2 isn't a local address on my systems. It happens to pong
if you ping, but that's a matter of its netmask (/255.0.0.0) and the
"bounce all traffic" feature.

> Less obvious example: routes added to `local' table.
> SIOCGIFCONF can never show them.

We're not talking about routes and rules, we're still talking about
network addresses and the corresponding subnet masks. Don't digress to
complicate things.

> On Thu, Sep 06, 2001 at 04:17:49PM +0200, Matthias Andree wrote:
> > I'm not sure where and why you deduce the idea this is about MTA loop
> > detection or peer recognition.
> 
> All other reasons are absolutely artificial.

Well, Postfix itself uses netmasks to obtain DEFAULT values. You can
override these, so there is absolutely no point in discussing this.

> > Or just use IPADDR_ANY...
> 
> If the mailer's socket is bound to IPADDR_ANY, it's hard to find which
> connection attempts will be handled locally, so the best way to handle it is
> to ask the admin.

The MTA is to handle every connection attempt, and it is to make other
decisions based on whether the /peer/ is on a direct link or is routed.
There's absolutely no point in making decisions based on the local
address the client connected to.

> The language of that section is amazing:
>          An SMTP MUST accept and recognize a domain literal for any of
> 	 its own IP addresses.
> What might be ``own IP addresses'' of ``an SMTP''?..
> Does SMTP server have ``own IP addresses'' at all?

Please stop these harassments. We're talking about broken or
non-portable SIOCGIFNETMASK behaviour and not ranting about anything
else, particularly not about Internet Standards.

-- 
Matthias Andree
