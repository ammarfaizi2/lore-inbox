Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262520AbTCRQbw>; Tue, 18 Mar 2003 11:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262526AbTCRQbv>; Tue, 18 Mar 2003 11:31:51 -0500
Received: from janus.zeusinc.com ([205.242.242.161]:49778 "EHLO
	zso-proxy.zeusinc.com") by vger.kernel.org with ESMTP
	id <S262520AbTCRQba>; Tue, 18 Mar 2003 11:31:30 -0500
Subject: Re: 2.5.64-mm8 breaks MASQ
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Shawn <core@enodev.com>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Hemminger <shemminger@osdl.org>
In-Reply-To: <20030318025523.7360f1d9.akpm@digeo.com>
References: <1047922184.3223.2.camel@iso-8590-lx.zeusinc.com>
	 <1047984726.3914.2.camel@localhost.localdomain>
	 <20030318025523.7360f1d9.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1048005523.2559.15.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
Date: 18 Mar 2003 11:38:43 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 05:55, Andrew Morton wrote:
> Shawn <core@enodev.com> wrote:
> >
> > This actually broke in -mm7, but I don't know what causes it.
> > 
> > I have to admit, I haven't even looked at the patch to see what changed.
> > Oh well, I suspect good ol' 65-mm1 will fix things up. If so, my TiVo
> > could stop holding it's breath. ;)
> > 
> > Anyone else seeing this?
> 
> Stephen is looking into it.  Please send him your iptables
> configuration info. 

My iptables config is just a simple one-liner as follows:

iptables -t nat -A POSTROUTING -o eth1 -j MASQUERADE

eth1 is an Aironet PCCARD wireless adapter connected to my corporate
network

eth0 is 3c556 (3c59x driver) Mini-PCI 10/100 with various systems
connected to it.

I also regularly NAT my VMware virtual machine (normally configured for
host only networking) which sits on vmnet1.

I've tried several variations of the iptables option, such as:

iptables -t nat -A POSTROUTING -s 192.168.4.1/24 -j MASQUERADE

iptables -t nat -A POSTROUTING -o ! eth0 -j MASQUERADE

All of these variations work without the brlock patches backed out. 
Actually, I haven't been able to get any MASQ/NAT options to work with
the brlock removal patches.

Let me know if you need more info.

Later,
Tom



