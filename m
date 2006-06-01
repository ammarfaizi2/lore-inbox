Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWFAJL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWFAJL1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 05:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWFAJL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 05:11:26 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:33684 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750817AbWFAJL0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 05:11:26 -0400
Date: Thu, 1 Jun 2006 11:11:25 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Kernel Netdev Mailing List <netdev@vger.kernel.org>
Subject: Re: 2.6.17-rc4: netfilter LOG messages truncated via NETCONSOLE
Message-ID: <20060601091124.GA31642@janus>
References: <20060531094626.GA23156@janus> <447DAEC9.3050003@trash.net> <20060531160611.GA25637@janus> <447DC613.10102@trash.net> <20060531172936.GB25788@janus> <447DD66C.30605@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447DD66C.30605@trash.net>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 07:46:20PM +0200, Patrick McHardy wrote:

[...]

> > ip -s link doesn't show any
> > dropped packets so far with any patch and I don't use traffic control
> > that I'm aware of. But I'm not sure what to make of "tc" output, maybe
> > because CONFIG_SHAPER is not set:
> > 
> > 	# tc -s -d qdisc show
> > 	RTNETLINK answers: Invalid argument
> > 	Dump terminated
> 
> Thats because you're missing CONFIG_NET_SCHED. Please enable it and
> try the tc command again, without it we can't see whether the qdisc
> (which is present even without CONFIG_NET_SCHED) just dropped the
> packets.

ok, now "tc -s -d qdisc show" says (after noticing missing netconsole
packets):

qdisc pfifo_fast 0: dev eth0 bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1
 Sent 155031 bytes 2067 pkt (dropped 0, overlimits 0 requeues 0) 
 backlog 0b 0p requeues 0 

-- 
Frank
