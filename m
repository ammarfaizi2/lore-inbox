Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268008AbTAIWDu>; Thu, 9 Jan 2003 17:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268014AbTAIWDt>; Thu, 9 Jan 2003 17:03:49 -0500
Received: from cs78149057.pp.htv.fi ([62.78.149.57]:53133 "EHLO
	devil.pp.htv.fi") by vger.kernel.org with ESMTP id <S268008AbTAIWDr>;
	Thu, 9 Jan 2003 17:03:47 -0500
Subject: Re: ipv6 stack seems to forget to send ACKs
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Wichert Akkerman <wichert@wiggy.net>
Cc: linux-kernel@vger.kernel.org, Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       netdev@oss.sgi.com
In-Reply-To: <20030108170139.GL22951@wiggy.net>
References: <20030108150201.GA30490@wiggy.net>
	 <Pine.LNX.4.44.0301081718340.4542-100000@dns.toxicfilms.tv>
	 <20030108170139.GL22951@wiggy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042150352.4688.15.camel@devil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Jan 2003 00:12:33 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wichert,

Looking at your trace it seems that the receiving machine is dropping
all packets that do not have traffic class set. Note that all segments
received with [class 0x2] get properly acked. The others probably don't
get to TCP at all. You might want to check your filters and QoS
policies.

BR,

	MikaL


On Wed, 2003-01-08 at 19:01, Wichert Akkerman wrote:
> Previously Maciej Soltysiak wrote:
> > I seem to be getting better results than you, i think that it is not an
> > issue of ipv6 implementation but simply the case of time sensitive
> > traffic fighting with other Internet traffic over tunnels through ipv4
> > networks.
> 
> Actually, I don't follow this. How could any kind of traffic shaping
> result in my client not sending ACKs, which is what the tcpdump
> seems to indicate? I can understand packets being dropped which
> would result in retransmits, but that is not the case here.
> 
> Wichert.
> 
> (usual I'm-no-network-guru-and-might-be-misreading-things disclaimer here)
