Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266982AbUBRAwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266998AbUBRAwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:52:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:8868 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S266982AbUBRAtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:49:21 -0500
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Santiago Leon <santil@us.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <40329A24.5070209@us.ibm.com>
References: <40329A24.5070209@us.ibm.com>
Content-Type: text/plain
Message-Id: <1077065118.1082.83.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 11:45:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-18 at 09:48, Santiago Leon wrote:
> Here's a patch that adds the inter-partition Virtual Ethernet driver for 
> newer IBM iSeries and pSeries systems:
> 
> The patch applies against 2.6.3-rc3...
> 
> Jeff, can you formally add this driver to 2.6?... The differences 
> between this driver and the 2.4 driver that you accepted are fairly 
> trivial (i.e. workqueues instead of tasklets)... The architectural 
> additions that I was waiting for have been applied to the mainline tree...
> 
> Comments and suggestions are always welcome...

Let me put my though police hat for a short while...

BITFIELDS ARE EVIL !!!

Especially when mapping things like HW registers... I know the p/iSeries
code is full of them, I'd strongly recommend getting rid of them.

The compiler is perfectly free, afaik, to re-order them, you have no
guarantee of your actual layout, and it's not portable (I know nothing
but PPC uses those drivers _right_ now, but still...)

So please, don't add more ;)
 
Ben.


