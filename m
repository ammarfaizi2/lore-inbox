Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTDONAy (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbTDONAy 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:00:54 -0400
Received: from mail.ithnet.com ([217.64.64.8]:60433 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261305AbTDONAw 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 09:00:52 -0400
Date: Tue, 15 Apr 2003 15:12:32 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to configure an ethernet dev as PtP ?
Message-Id: <20030415151232.653d0f39.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.53.0304150759560.457@chaos>
References: <20030415102109.4802ddd0.skraw@ithnet.com>
	<Pine.LNX.4.53.0304150759560.457@chaos>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003 08:10:59 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> On Tue, 15 Apr 2003, Stephan von Krawczynski wrote:
> 
> > Hello all,
> >
> > I tried to configure an ethernet device as a pointopoint link recently,
> > just to find out that this does not work as one would expect via:
> >
> > ifconfig eth0 192.168.1.1 pointopoint 192.168.5.1 up
> >
> > I tried on kernel 2.4.21-pre6 and 2.2.19 (just to name two), both the same.
> > It comes up as:
> >
> > eth0      Link encap:Ethernet  HWaddr 00:04:76:F7:E9:17
> >           inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
> >           UP BROADCAST MULTICAST  MTU:1500  Metric:1
> >
> > I do not understand why this does not work out just like another
> > ptp-interface like isdn:
> >
> > isdn0     Link encap:Ethernet  HWaddr FC:FC:00:00:00:00
> >           inet addr:192.168.1.1  P-t-P:192.168.5.1  Mask:255.255.255.255
> >           UP POINTOPOINT RUNNING NOARP  MTU:1500  Metric:1
> >
> > Is there anything I mis-understood or a good reason for not being able to
> > make eth pointopoint?
> >
> > I have the feeling this question is pretty brain-dead, but anyway, maybe
> > some kind soul can drop a few words ...
> > --
> > Regards,
> > Stephan
> 
> Because ethernet is not a point-to-point interface. At the hardware
> level, ethernet talks from one hardware address to another hardware
> address, i.e., the IEEE station address. You need ARP to find out
> what that address is so you can't "get there from here." But, you
> can do essentially the same thing, you set up a host route on
> that interface.

Well, the world today really knows ptp-type ethernet-interfaces in WAN
environment, this is where the question comes from. Think of simply a two-ended
bridged WAN connection. It is in fact (like) ptp.

> Use a 'private' network address...

That is only a _good_ alternative on first sight, but thinking again about it
you might as well say that in a rather big-sized WAN environment with lots of
hosts involved that route all kinds of private ips it is a really nice idea to
connect the interconnecting wan-boxes with ptp _not_ burning down additional
(private) subnets without real need. (remember, if you have lots of wan
connections you need lots of private subnets, but if you could use ptp you need
_none_)

-- 
Regards,
Stephan
