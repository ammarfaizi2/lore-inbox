Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTHVPJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTHVPJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:09:50 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:60432 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264224AbTHVPJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:09:44 -0400
Date: Fri, 22 Aug 2003 16:09:39 +0100
From: Christoph Hellwig <hch@infradead.org>
To: torvalds@transmeta.com, Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.0-test3-bk9][ISDN] sedlbauer_cs.c: remove release timer
Message-ID: <20030822160939.A17745@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	torvalds@transmeta.com,
	Vinay K Nallamothu <vinay-rc@naturesoft.net>,
	LKML <linux-kernel@vger.kernel.org>
References: <1061564783.1108.38.camel@lima.royalchallenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1061564783.1108.38.camel@lima.royalchallenge.com>; from vinay-rc@naturesoft.net on Fri, Aug 22, 2003 at 08:36:23PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 08:36:23PM +0530, Vinay K Nallamothu wrote:
> Hi Christoph,
> 
> This patch removes the PCMCIA release timer you missed out in earlier
> patch. This patch is required for successful compilation of the driver.

Oops.  Linus, can you please apply the patch below?

--- linux-2.6.0-test3-bk9/drivers/isdn/hisax/sedlbauer_cs.c	2003-08-22 15:04:47.000000000 +0530
+++ linux-2.6.0-test3-nvk/drivers/isdn/hisax/sedlbauer_cs.c	2003-08-22 20:26:49.000000000 +0530
@@ -647,7 +647,6 @@
 
 	/* XXX: this really needs to move into generic code.. */
 	while (dev_list != NULL) {
-		del_timer(&dev_list->release);
 		if (dev_list->state & DEV_CONFIG)
 			sedlbauer_release(dev_list);
 		sedlbauer_detach(dev_list);
