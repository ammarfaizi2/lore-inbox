Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131716AbRCONnp>; Thu, 15 Mar 2001 08:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131717AbRCONnf>; Thu, 15 Mar 2001 08:43:35 -0500
Received: from netsonic.fi ([194.29.192.20]:29714 "EHLO nalle.netsonic.fi")
	by vger.kernel.org with ESMTP id <S131716AbRCONn0>;
	Thu, 15 Mar 2001 08:43:26 -0500
Date: Thu, 15 Mar 2001 15:42:37 +0200 (EET)
From: Sampsa Ranta <sampsa@netsonic.fi>
To: Jerome Tollet <Jerome.Tollet@qosmos.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.2 network performances
In-Reply-To: <3AB08FAC.657784CA@qosmos.net>
Message-ID: <Pine.LNX.4.33.0103151540240.856-100000@nalle.netsonic.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Jerome Tollet wrote:

> Hello, i have a problem with the network layer of linux kernel 2.4.2
> I wrote a minimalist program which basically sends UDP datagrams over
> the network in an infinite loop.
> Under Linux 2.2.x, this program floods the network and my xosview prints
> that 12 MB/s are sent over my 100Mbit ethernet.
>
> Under Linux 2.4.2, this program can't flood the network because my
> xosview (the same ;-) ) tells me that 4.6MB/s are sent over my ethernet
> although my cpu is not overloaded.
>
> I think that Linux 2.4.2 limits the rate of packets sent over the
> network with some soft parameters.
> *Does anyone have any idea ?
> *Could someone explains me the new
> /proc/sys/net/core/{hot_list_length|no_cong|no_cong_thresh|mod_cong|lo_cong}
> parameters ?
> *Where could i see in the code this soft limits ?

Yesterday I discovered that the load I can throw out to network seems to
depend on other activities running on machine. I was able to get
throughput of 33M/s with ATM when machine was idle, while I compiled
kernel at same time, the throughput was 135M/s.

So, I suggest you try to compile kernel while running your UDP stream!

 - Sampsa Ranta


