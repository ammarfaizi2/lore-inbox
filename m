Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWHPXcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWHPXcx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWHPXcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:32:53 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12230
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751239AbWHPXcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:32:52 -0400
Date: Wed, 16 Aug 2006 16:32:52 -0700 (PDT)
Message-Id: <20060816.163252.64000941.davem@davemloft.net>
To: linas@austin.ibm.com
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, akpm@osdl.org, jeff@garzik.org,
       netdev@vger.kernel.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, Jens.Osterkamp@de.ibm.com
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060816233028.GO20551@austin.ibm.com>
References: <20060816.143203.11626235.davem@davemloft.net>
	<200608170016.47072.arnd@arndb.de>
	<20060816233028.GO20551@austin.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linas@austin.ibm.com (Linas Vepstas)
Date: Wed, 16 Aug 2006 18:30:28 -0500

> Why would you want o do this? It seems like a cruddier strategy 
> than what we can already do  (which is to never get an transmit
> interrupt, as long as the kernel can shove data into the device fast
> enough to keep the queue from going empty.)  The whole *point* of a 
> low-watermark interrupt is to never have to actually get the interrupt, 
> if the rest of the system is on its toes and is supplying data fast
> enough.

As long as TX packets get freed within a certain latency
boundary, this kind of scheme should be fine.
