Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVEXEEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVEXEEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 00:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEXEEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 00:04:00 -0400
Received: from gate.crashing.org ([63.228.1.57]:19150 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261221AbVEXED4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 00:03:56 -0400
Subject: Re: ide-cd vs. DMA
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: karim@opersys.com
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4292A69C.4070605@opersys.com>
References: <1116891772.30513.6.camel@gaston> <42929F2F.8000101@opersys.com>
	 <1116905090.4992.7.camel@gaston>  <4292A69C.4070605@opersys.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 14:03:38 +1000
Message-Id: <1116907419.4992.11.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-23 at 23:59 -0400, Karim Yaghmour wrote:
> Benjamin Herrenschmidt wrote:
> > Well, not sure what's wrong here, but ATAPI errors shouldn't normally
> > result in stopping DMA. We may want to just blacklist your drive rather
> > than having this stupid fallback. In this case, I suspect it's
> > CSS/region issue with a DVD.
> 
> Here's a little bit more info:
> 
> Here's from dmesg:
> hdc: SAMSUNG SC-140B, ATAPI CD/DVD-ROM drive
> hdc: ATAPI 40X CD-ROM drive, 128kB Cache, UDMA(33)

  .../...

That's a lot of problems ... I would blame HW here, either a bad cable,
bad master/slave jumpers or a bad drive in the chain... or maybe as you
suggested, a problem with the controller.

Ben.


