Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSGYVXZ>; Thu, 25 Jul 2002 17:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSGYVXZ>; Thu, 25 Jul 2002 17:23:25 -0400
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:14605 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S316446AbSGYVXZ>;
	Thu, 25 Jul 2002 17:23:25 -0400
Date: Thu, 25 Jul 2002 22:34:11 +0100
From: Bruce Cran <bruce@cran.org.uk>
To: linux-kernel@vger.kernel.org
Subject: wrong mtu value in /proc/net/route
Message-ID: <20020725223410.A18965@steely.transient>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found something strange going on in 2.4 kernels - when I run
'netstat -r' I get the routing table from /proc/net/route.   The MSS
value reported is only 40 bytes, and when I run 'cat
/proc/net/route I'm told that the _MTU_ is 40 bytes.   I thought the MSS was
supposed to be the MTU - 40 bytes, not 40 bytes in
total, where the MTU for ethernet is 1500.  If I run ifconfig, it reports the 
correct MTU of 1500 for eth0 and 16463 for lo.   This computer has a NetGear 
FA311 card, and is running 2.4.19-pre7-ac2, though I've also seen this 
happening on a 2.4.18 kernel.

--

Bruce Cran
