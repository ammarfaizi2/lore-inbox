Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964856AbVHYGIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbVHYGIt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 02:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbVHYGIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 02:08:49 -0400
Received: from web33311.mail.mud.yahoo.com ([68.142.206.126]:64936 "HELO
	web33311.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964856AbVHYGIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 02:08:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=i+Lw/FhCA/EnSE4h/LsBPcsJrmbnc5FEBbSMNEnJTONuN4O9EWMosLQbH2iLgvk5Ymy7t+wyGSS8ZQIZGr+J72PLs2ztGN7nYyA4KBJ2ETOtzCAliIDOf3x5morckOZbQq6X5UEwuxK4Zjx/degkkc9hVto2MOfZI2w3fo/DTHY=  ;
Message-ID: <20050825060843.15874.qmail@web33311.mail.mud.yahoo.com>
Date: Wed, 24 Aug 2005 23:08:43 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Re: 2.6.12 Performance problems
To: Ben Greear <greearb@candelatech.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <430D4E6D.1090200@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Ben Greear <greearb@candelatech.com> wrote:

> Danial Thom wrote:
> 
> > I think the concensus is that 2.6 has made
> trade
> > offs that lower raw throughput, which is what
> a
> > networking device needs. So as a router or
> > network appliance, 2.6 seems less suitable. A
> raw
> > bridging test on a 2.0Ghz operton system:
> > 
> > FreeBSD 4.9: Drops no packets at 900K pps
> > Linux 2.4.24: Starts dropping packets at 350K
> pps
> > Linux 2.6.12: Starts dropping packets at 100K
> pps
> 
> I ran some quick tests using kernel 2.6.11, 1ms
> tick (HZ=1000), SMP kernel.
> Hardware is P-IV 3.0Ghz + HT on a new
> SuperMicro motherboard with 64/133Mhz
> PCI-X bus.  NIC is dual Intel pro/1000.  Kernel
> is close to stock 2.6.11.
> 
> I used brctl to create a bridge with the two
> GigE adapters in it and
> used pktgen to stream traffic through it
> (250kpps in one direction, 1kpps in
> the other.)
> 
> I see a reasonable amount of drops at 250kpps
> (60 byte packets):
> about 60,000,000 packets received, 20,700
> dropped.
> 
> Interestingly, the system is about 60% idle
> according to top,
> and still dropping pkts, so it would seem that
> the system could
> be better utilized!
> 
> Ben
>

What GigE adapters did you use? Clearly every
driver is going to be different. My experience is
that a 3.4Ghz P4 is about the performance of a
2.0Ghz Opteron. I have to try your tuning script
tomorrow.

If your test is still set up, try compiling
something large while doing the test. The drops
go through the roof in my tests.

Danial


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
