Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129841AbRCGB4x>; Tue, 6 Mar 2001 20:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRCGB4o>; Tue, 6 Mar 2001 20:56:44 -0500
Received: from [63.95.87.168] ([63.95.87.168]:57360 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S129841AbRCGB42>;
	Tue, 6 Mar 2001 20:56:28 -0500
Date: Tue, 6 Mar 2001 20:55:17 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Bryan Rittmeyer <bryan@ixiacom.com>, linux-kernel@vger.kernel.org
Subject: Re: conducting TCP sessions with non-local IPs
Message-ID: <20010306205517.H3372@xi.linuxpower.cx>
In-Reply-To: <3AA54902.AFF8550@ixiacom.com> <20010306170551.D2244@xi.linuxpower.cx> <3AA592FF.5107E508@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <3AA592FF.5107E508@matchmail.com>; from mfedyk@matchmail.com on Tue, Mar 06, 2001 at 05:46:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2001 at 05:46:39PM -0800, Mike Fedyk wrote:
> Gregory Maxwell wrote:
> > 
> > On Tue, Mar 06, 2001 at 12:30:58PM -0800, Bryan Rittmeyer wrote:
> > > Hello linux-kernel,
> > >
> > > Is there any way to conduct TCP sessions (IE have a userland process
> > > connect out, or accept connections) using non-local IPs? By "non-local"
> > > I just mean IPs that aren't assigned to an interface, but do fall into
> > > the network range of a running interface (so netmask, gateway, etc are
> > > "known").
> > >
> > > For example, I want to bring up an interface for 10.0.0.0/255.255.255.0
> > > and assign it IP 10.0.0.1 Then, I want a process to accept TCP
> > [snip]
> > 
> > /sbin/ip addr add 10.2.0.0/24 dev eth0
> > 
> > Tada
> How would you deal with the other computer responding to the host "port not
> reachable"?

I didn't pick-up on the fact that you planned on have other computers
listening with those addresses.

This won't work without support from your routing device if you actually
have hosts on the addresses, just because of ARP.

You can make this work, if, you can control and configure the router
  1. You can configure your router to direct the needed ports to your Linux
	box and not the real hosts. (Linux can do this)

If you can firewall on the victim boxes, you could block their 'not
reachable' reply, but that doesn't solve ARP. You could probably make a
trivial change to Linux and run it in promiscuous mode to achieve this. It's
more likely the first will be a better option for you.

What are you doing anyways? :)
