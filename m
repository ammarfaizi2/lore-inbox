Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbULHU6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbULHU6t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbULHU6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:58:49 -0500
Received: from imo-d01.mx.aol.com ([205.188.157.33]:6610 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP id S261357AbULHU6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:58:46 -0500
Date: Wed, 08 Dec 2004 15:58:29 -0500
From: FoObArf00@netscape.net
To: chrisw@osdl.org (Chris Wright)
Cc: linux-kernel@vger.kernel.org
Subject: Re: IGMP packets?
MIME-Version: 1.0
Message-ID: <00640596.1F2101FF.023DF18B@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 66.146.57.210
X-AOL-Language: english
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 3 machines.  A (eth0) is connected to B (eth1) with a cross over cable and B (eth0) and C (eth0) are on a switch.  I want to forward the igmp queries and reports that A (eth1) generates when joining/leaving a multicast group on B (eth1) from B(eth0) to C (eth0).  I put the code to do this on different places such as ip_rcv, ip_route_input, etc and no luck.  The weird thing is that it works when I do a tcpdump on B's eth1. 
 
A-(eth0)----(eth1)-B-(eth0)----(eth0)-C

Thanks.

Chris Wright <chrisw@osdl.org> wrote:

>* FoObArf00@netscape.net (FoObArf00@netscape.net) wrote:
>> I have been trying to analyze igmp packets (queries, reports) with
>> ttl of 1 ,of course, in the kernel and ran into a weird situation.
>> Only when an interface is in promiscuous mode (i.e. tcpdump), the igmp
>> packets get to ip_rcv on ip_input.c.  I was wondering if someone can
>> point in the right direction on how/where to get the these packets when
>> not doing a tcpdump.  Thanks
>
>Could you be more specific?  Which machines are involved (e.g. IIRC the
>igmp report is not looped back locally).  What do you mean by analyze in
>the kernel?
>
>thanks,
>-chris
>

__________________________________________________________________
Switch to Netscape Internet Service.
As low as $9.95 a month -- Sign up today at http://isp.netscape.com/register

Netscape. Just the Net You Need.

New! Netscape Toolbar for Internet Explorer
Search from anywhere on the Web and block those annoying pop-ups.
Download now at http://channels.netscape.com/ns/search/install.jsp
