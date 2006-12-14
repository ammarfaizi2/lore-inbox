Return-Path: <linux-kernel-owner+w=401wt.eu-S932623AbWLNL3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWLNL3D (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWLNL3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:29:02 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:44584 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932623AbWLNL3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:29:00 -0500
Date: Thu, 14 Dec 2006 12:26:12 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <Pine.LNX.4.61.0612141206500.6223@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0612141224190.6223@yvahk01.tjqt.qr>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <1166044471.11914.195.camel@localhost.localdomain>
 <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612131522310.5718@woody.osdl.org>
 <Pine.LNX.4.61.0612141206500.6223@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  irqreturn_t uio_handler(...) {
>      disable interrupts for this dev;
>      set a flag that notifies userspace the next best time;
>      seomstruct->flag |= IRQ_ARRIVED;
>      return IRQ_HANDLED;
>  }

Rather than IRQ_HANDLED, it should have been: remove this irq handler 
from the irq handlers for irq number N, so that it does not get called 
again until userspace has acked it.

See, maybe I don't have enough clue yet to exactly figure out why you 
say it does not work. However, this is how simple people see it 8)


	-`J'
-- 
