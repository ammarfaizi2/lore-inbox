Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314069AbSEAWQA>; Wed, 1 May 2002 18:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314072AbSEAWP7>; Wed, 1 May 2002 18:15:59 -0400
Received: from jffdns02.or.intel.com ([134.134.248.4]:22747 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S314069AbSEAWP7>; Wed, 1 May 2002 18:15:59 -0400
Message-ID: <BD9B60A108C4D511AAA10002A50708F22C1500@orsmsx118.jf.intel.com>
From: "Leech, Christopher" <christopher.leech@intel.com>
To: "'Steffen Persvold'" <sp@scali.com>,
        "Linux-Kernel (linux-kernel@vger.kernel.org)" 
	<linux-kernel@vger.kernel.org>
Subject: RE: Plan for e100-e1000 in mainline
Date: Wed, 1 May 2002 15:15:44 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Another funny thing is that the latency for the gigabit 
> adapter (e1000) is also higher than fast ethernet (eepro100) 
> with small messages (<256 bytes) :

You could try setting the RxIntDelay module parameter to 0, that should
improve round trip latency.  The balance between latency on the receive path
and interrupt rate can be difficult to manage, hopefully a dynamic method
like NAPI will result in Ethernet drivers that need less hand tuning.

--
Chris Leech <christopher.leech@intel.com>
Network Software Engineer
LAN Access Division, Intel Corporation
