Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271714AbTHRNBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 09:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271814AbTHRNAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 09:00:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30445 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271813AbTHRNAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 09:00:36 -0400
Date: Mon, 18 Aug 2003 05:53:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: skraw@ithnet.com, willy@w.ods.org, alan@lxorguk.ukuu.org.uk,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030818055329.44db9262.davem@redhat.com>
In-Reply-To: <20030818125158.GA18699@alpha.home.local>
References: <200308171555280781.0067FB36@192.168.128.16>
	<1061134091.21886.40.camel@dhcp23.swansea.linux.org.uk>
	<200308171759540391.00AA8CAB@192.168.128.16>
	<1061137577.21885.50.camel@dhcp23.swansea.linux.org.uk>
	<200308171827130739.00C3905F@192.168.128.16>
	<1061141045.21885.74.camel@dhcp23.swansea.linux.org.uk>
	<20030817224849.GB734@alpha.home.local>
	<20030817223118.3cbc497c.davem@redhat.com>
	<20030818133957.3d3d51d2.skraw@ithnet.com>
	<20030818044419.0bc24d14.davem@redhat.com>
	<20030818125158.GA18699@alpha.home.local>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 14:51:58 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> > 1) consider how you might want to make that configurable
> >    by the user
> 
> ip route ... src ... is really fine to me for the IP part, and I would have
> expected it to act on ARP too ;-)

More precisely, "preferred source".

> > 2) what the default behavior should be
> 
> I think we should apply the exact same source selection as IP to ARP.

This is what setting the "arp_filter" sysctl on a device does
if you've setup the preferred source on your routes correctly.
If we would use that IP address to speak to the destination in
the ARP, we respond, else we do not.

I've quoted the 'arp_filter' entry in Documentation/sysctl/ip-sysctl.txt
please give it a read.
