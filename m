Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271423AbTHRMNS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 08:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271420AbTHRMLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 08:11:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52716 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271415AbTHRMLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 08:11:02 -0400
Date: Mon, 18 Aug 2003 05:03:57 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Bas Bloemsaat" <bloemsaa@xs4all.nl>
Cc: willy@w.ods.org, alan@lxorguk.ukuu.org.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030818050357.1a5b8d6e.davem@redhat.com>
In-Reply-To: <012b01c36581$6fd1c1b0$c801a8c0@llewella>
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
	<20030818133957.3d3d51d2.skraw@ithnet.com>
	<012b01c36581$6fd1c1b0$c801a8c0@llewella>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 14:08:05 +0200
"Bas Bloemsaat" <bloemsaa@xs4all.nl> wrote:

> > > Replying again... Alan does mention in the paragraph you've quoted
> > > to use arpfilter, which works for every case imaginable.
>
> No it doesn't. When I have two nics on DHCP on the same ethernet segment, it
> cannot be made to work. I don't know the ip addresses beforehand. And if if
> I would get them with scripting and crafted some rules on the fly, there's
> no way I can be sure I'll get the same IP's on a renew, so I'd have to check
> often.

You don't understand how 'arpfilter' works.

It's a netfilter module that allows you to block ARP packets
going in and out of the system using any criteria you want.
It can block on device, on src MAC address, on destination
MAC address, whatever you want.
