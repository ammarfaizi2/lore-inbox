Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263351AbUJ2BOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbUJ2BOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263350AbUJ2BNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:13:01 -0400
Received: from 0.fe-0-0-0.c1.pfn.citynetwireless.net ([209.218.71.2]:37837
	"EHLO core.citynetwireless.net") by vger.kernel.org with ESMTP
	id S263285AbUJ2BHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 21:07:24 -0400
Date: Thu, 28 Oct 2004 20:07:21 -0500
From: parker@citynetwireless.net
To: linux-kernel@vger.kernel.org
Subject: ICMP ttl-exceeded packets not sourced correctly
Message-ID: <20041029010721.GA25817@core.citynetwireless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there's a problem with the ICMP code...

Say you have a router, and it's multihomed to two different isp's,
say cogentco.com and qwest.net as your upstreams.
On your cogent interface, you have the ip address on the /30 assigned by cogent,
with reverse dns being blahblah.demarc.cogentco.com on the qwest interface.
Same story with qwest, with reverse dns being whatever.qwest.net.
Now let's say someone out on the internet with ip address of 1.1.1.1 runs
a traceroute into your network and his incoming path to your network comes over qwest.
Your router's hop should source its ICMP ttl-exceeded code (the traceroute hop) on
its qwest /30 ip address, because thats where the traceroute got triggered.
ICMP ttl-exceeded code's response should not be originated from the interface
holding the route, but should be origianted from the interface that got hit
with the traceroute.

-- 
Bubba Parker
Systems Administrator
CityNet LLC
http://www.citynetinfo.com/
