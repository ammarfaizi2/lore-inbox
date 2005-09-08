Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVIHNFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVIHNFL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVIHNFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:05:10 -0400
Received: from ip18.tpack.net ([213.173.228.18]:24255 "HELO mail.tpack.net")
	by vger.kernel.org with SMTP id S1751325AbVIHNFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:05:09 -0400
Subject: Re: [PATCH] 3c59x: read current link status from phy
From: Tommy Christensen <tommy.christensen@tpack.net>
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Netdev List <netdev@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de>
References: <200509080125.j881PcL9015847@hera.kernel.org>
	 <431F9899.4060602@pobox.com>
	 <Pine.LNX.4.63.0509081351160.21354@dingo.iwr.uni-heidelberg.de>
Content-Type: text/plain
Message-Id: <1126184700.4805.32.camel@tsc-6.cph.tpack.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Sep 2005 15:05:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-08 at 13:58, Bogdan Costescu wrote:
> Can the original poster give an explanation ? I've enjoyed a rather 
> well functioning 3c59x driver for the past ~6 years without such 
> double reading. Plus:
> - this operation is I/O expensive
> - it is performed inside a region protected by a spinlock
> - it is performed often, every 60 seconds
> 
> Is there some specific hardware that exhibits a problem that is solved 
> by this double reading ?

Nothing critical. The idea is to avoid an extra delay of 60 seconds
before detecting link-up.

Please see http://bugzilla.kernel.org/show_bug.cgi?id=5025


-Tommy

