Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271841AbTGXXll (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 19:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271842AbTGXXll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 19:41:41 -0400
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:62216 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S271841AbTGXXlh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 19:41:37 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Fredrik Tolf <fredrik@dolda2000.cjb.net>
To: linux-kernel@vger.kernel.org
Subject: Net device byte statistics
Date: Fri, 25 Jul 2003 01:56:46 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200307250156.47108.fredrik@dolda2000.cjb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have set up a network statistics gathering script, which is based on the 
byte statistics from /proc/net/dev, but it has always been reporting too 
little.
Yesterday, I discovered that the cause was that these statistics are defined 
as unsigned longs in include/linux/netdevice.h. Surely, this must be strange? 
They overflow at least once a day for me.
On the other hand, I cannot imagine that noone would have thought of it. What 
is the reason for this? Is there another interface that I should use instead 
of /proc/net/dev to gather byte statistics for interfaces?
Shouldn't they be changed to unsigned long longs in any case?

Fredrik Tolf

