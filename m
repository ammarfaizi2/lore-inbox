Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbUAaHg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 02:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUAaHg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 02:36:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:22289 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263723AbUAaHg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 02:36:56 -0500
Date: Sat, 31 Jan 2004 08:36:03 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Kallol Biswas <kallol.biswas@s2io.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Fwd: receive path with fragmented skbs
Message-ID: <20040131073603.GA17225@alpha.home.local>
References: <1075504343.21310.23.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075504343.21310.23.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

you should have posted this to the netdev list : netdev@oss.sgi.com.
You don't need to resend, I have CC'd it.

Willy

On Fri, Jan 30, 2004 at 03:12:24PM -0800, Kallol Biswas wrote:
> Hello,
>       We have been developing drivers and networking software  on
> a 10 gigabit ethernet adapter from S2io Inc (www.s2io.com). There is a
> requirement that the ethernet header, IP+TCP headers have to be cache
> aligned and the payload and the IP+TCP headers have to be in different
> fragments. So we have created receive path skbs with data size big
> enough to hold the ethernet header and two fragments, one fragment for
> the IP+TCP header and the other for payload. The card can  directly dma
> into the three receive scatter buffers when a frame arrives.
> 
> We could not get ping working with this design of receive skbs,
> but if a skb is linearized with skb_linearize() before calling
> netif_rx(), ping works.
> 
> /proc/net/snmp was printed, no frame had any error. Probably no one has
> ever tested the receive path of the stack with fragmented skbs, am I
> right? One of the ways this problem can be debugged is to find out where
> exactly the packets get dropped. Any comment?
> 
> Kallol 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
