Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSIEWIx>; Thu, 5 Sep 2002 18:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318313AbSIEWIZ>; Thu, 5 Sep 2002 18:08:25 -0400
Received: from tempest.prismnet.com ([209.198.128.6]:45579 "EHLO
	tempest.prismnet.com") by vger.kernel.org with ESMTP
	id <S318305AbSIEWGn>; Thu, 5 Sep 2002 18:06:43 -0400
From: Troy Wilson <tcw@tempest.prismnet.com>
Message-Id: <200209052211.g85MBFdm099387@tempest.prismnet.com>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <Pine.GSO.4.30.0209051648020.17973-100000@shell.cyberus.ca>
 "from jamal at Sep 5, 2002 04:59:47 pm"
To: jamal <hadi@cyberus.ca>
Date: Thu, 5 Sep 2002 17:11:15 -0500 (CDT)
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So if i understood correctly (looking at the intel site) the main value
> add of this feature is probably in having the CPU avoid reassembling and
> retransmitting.

Quoting David S. Miller:

dsm> The performance improvement comes from the fact that the card
dsm> is given huge 64K packets, then the card (using the given ip/tcp
dsm> headers as a template) spits out 1500 byte mtu sized packets.
dsm> 
dsm> Less data DMA'd to the device per normal-mtu packet and less
dsm> per-packet data structure work by the cpu is where the improvement
dsm> comes from.


> Do you have any stats from the hardware that could show
> retransmits etc;

  I'll gather netstat -s after runs with and without TSO enabled.
Anything else you'd like to see?


> have you tested this with zero copy as well (sendfile)

  Yes.  My webserver is Apache 2.0.36, which uses sendfile for anything
over 8k in size.  But, iirc, Apache sends the http headers using writev.

Thanks,

- Troy


