Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271399AbTHRLkG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 07:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271400AbTHRLkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 07:40:06 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:34690 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271399AbTHRLkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 07:40:00 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 18 Aug 2003 13:39:57 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, bloemsaa@xs4all.nl,
       marcelo@conectiva.com.br, netdev@oss.sgi.com, linux-net@vger.kernel.org,
       layes@loran.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030818133957.3d3d51d2.skraw@ithnet.com>
In-Reply-To: <20030817223118.3cbc497c.davem@redhat.com>
References: <20030728213933.F81299@coredump.scriptkiddie.org>
	<200308171509570955.003E4FEC@192.168.128.16>
	<200308171516090038.0043F977@192.168.128.16>
	<1061127715.21885.35.camel@dhcp23.swansea.linux.org.uk>
	<200308171555280781.0067FB36@192.168.128.16>
	<1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
	<200308171759540391.00AA8CAB@192.168.128.16>
	<1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
	<200308171827130739.00C3905F@192.168.128.16>
	<1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk>
	<20030817224849.GB734@alpha.home.local>
	<20030817223118.3cbc497c.davem@redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003 22:31:18 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On Mon, 18 Aug 2003 00:48:49 +0200
> Willy Tarreau <willy@w.ods.org> wrote:
> 
> > On Sun, Aug 17, 2003 at 06:24:06PM +0100, Alan Cox wrote:
> >  
> > > So stick the address on eth0 not on lo since its not a loopback but an
> > > eth0 address, then use arpfilter so you don't arp for the invalid magic
> > > shared IP address, or NAT it, or it may work to do
> > > 
> > >          ip route add nexthop-addr src my-virtual-addr dev eth0 scope
> > >          local onlink ip route add default src my-virtual-addr via
> > >          nexthop-addr dev eth0 scope global
> >  
> > I have a case where this doesn't work
> 
> Replying again... Alan does mention in the paragraph you've quoted
> to use arpfilter, which works for every case imaginable.
> 
> The facilities to solve these problems are there, people simply
> don't want to use them.

It would be probably a good thing if anybody ever found a _positive_ scenario
where your view of the arp-world has _advantages_ compared to what the vast
majority of people I ever talked to sees as _expected_ behaviour...
(Please don't argue that my "vast majority" is not necessarily _the_ vast
majority, because that is true for merely every human being on this planet and
beyond)
I mean everybody is willing to follow you if you could say: "look at these type
of wide-spread operations and notice the positive (config shortening or
whatever) influence of the current default behaviour."
Can you please give us a striking example of a widespread application where
current behaviour is a requirement or at least a very positive thing?

Regards,
Stephan
