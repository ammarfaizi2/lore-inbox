Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVCKMTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVCKMTw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 07:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVCKMTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 07:19:51 -0500
Received: from [220.233.7.36] ([220.233.7.36]:62108 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S262687AbVCKMSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 07:18:07 -0500
Date: Fri, 11 Mar 2005 23:16:55 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com, pekkas@netcore.fi, yoshfuji@linux-ipv6.org
Subject: ipv6 and ipv4 interaction weirdness
Message-ID: <20050311121655.GE14146@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just had some issues with ssh and trying to get it to bind to all ipv6
and ipv4 addresses to it via :: and 0.0.0.0. The problem was that it'd
only let one succeed. If 0.0.0.0:22 was successful then :: port 22 could
not happen and neither could my ipv6 addy port 22 as it would get the
'address already in use' error from bind(). The reverse was also true.
If it bound to :: port 22 then 0.0.0.0:22 would fail.

On the other hand if I got it to bind to each address individually then
both ipv4 (2 addresses) and ipv6 (1 address) binds would succeed.

Maybe I'm just looking at it wrong but shouldn't ipv4 and ipv6 interfere
with each other?

I'm using kernel 2.6.11-ac2 with OpenSSH_3.8.1p1 Debian-8.sarge.4,
OpenSSL 0.9.7e 25 Oct 2004 and glibc 2.3.2 (debian version
2.3.2.ds1-20).

-- 
    "It goes against the grain of modern education to teach children to
    program. What fun is there in making plans, acquiring discipline in
    organising thoughts, devoting attention to detail and learning to be
    self-critical?" -- Alan Perlis
