Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265115AbSJaCcD>; Wed, 30 Oct 2002 21:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265112AbSJaCcD>; Wed, 30 Oct 2002 21:32:03 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:12010 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S265116AbSJaCcB>;
	Wed, 30 Oct 2002 21:32:01 -0500
Date: Wed, 30 Oct 2002 18:38:21 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: How to get a local IPv4 address from within a kernel module?
Message-ID: <20021031023821.GA2156@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juan Gomez wrote :
> 
> Is there any standard way of doing this? I looked into ipv4 code but I did
> not find a function that would provide a direct, clean way to query the
> local IPv4 addresses of a given node.

	There is no such thing as the local IPv4 addresses of a given
node. IP addresses are assigned for each network interfaces, so you
may have more than one IP address. Note that I have many systems that
don't have any "eth0" and still have many IP addresses (on wlan0,
ppp0, bnep0...).
	On top of that, the DNS may assign an IP address that map to
your current hostname (which may correspond to one of the addresses
above). That's purely a user space stuff.

	So, you are basically starting on a wrong assumption, the
information you are looking for doesn't exist, and I therefore suspect
that you need to rethink the thing you want to do.

	I suggest you use a user space application to pick the IP
address most relevant to your setup (i.e. policy decision) and inject
it in your module.

	Good luck,

	Jean
