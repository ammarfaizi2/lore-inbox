Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSIIHux>; Mon, 9 Sep 2002 03:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSIIHux>; Mon, 9 Sep 2002 03:50:53 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:63245 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315928AbSIIHuw>; Mon, 9 Sep 2002 03:50:52 -0400
Date: Mon, 9 Sep 2002 09:55:23 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Dmitry N. Hramtsov" <hdn@nsu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Connectivity problem (kernel bug?)
Message-ID: <20020909075522.GD26075@louise.pinerecords.com>
References: <Pine.LNX.4.44.0209091432120.16415-100000@aurora.nsu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209091432120.16415-100000@aurora.nsu.ru>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 14 days, 8:35
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've tried to analyse this and come to a conclusion that this is Linux1 fault.
> Well, what is going on:
> 
> 1. Linux2 (10.0.0.3) send icmp echo request to 10.1.0.2 thru 10.0.0.1
>      10.0.0.3 -> 10.0.0.1
> 2. Cisco receives it and forwards to Linux2 thru VLAN 2
>      10.1.0.1 -> 10.1.0.2
> 3. Linux1 receives icmp request thru eth0.2
> 
> All of this stages may be observed using tcpdump on Linux1 and Linux2.
> 
> 4. Nothing happened any more! ==8-O
> No reply sends from Linux1!
> Not from eth0 nor from eth0.2!

Do you have IP forwarding enabled?
echo 1 >/proc/sys/net/ipv4/ip_forward

T.
