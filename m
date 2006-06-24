Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWFXSMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWFXSMu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 14:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWFXSMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 14:12:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:698 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751017AbWFXSMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 14:12:49 -0400
Subject: Re: [RFC PATCH 2.6.17-mm1 4/3] ieee1394: convert
	ieee1394_transactions from semaphores to waitqueue
From: Arjan van de Ven <arjan@infradead.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <449D7A53.4080605@s5r6.in-berlin.de>
References: <449BEBFB.60302@s5r6.in-berlin.de>
	 <200606230904.k5N94Al3005245@shell0.pdx.osdl.net>
	 <30866.1151072338@warthog.cambridge.redhat.com>
	 <tkrat.df6845846c72176e@s5r6.in-berlin.de>
	 <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de>
	 <tkrat.e74b06c4105348f6@s5r6.in-berlin.de>
	 <tkrat.2ff7b57397a5a37e@s5r6.in-berlin.de>
	 <tkrat.3f9c07538e381afd@s5r6.in-berlin.de>
	 <449D7A53.4080605@s5r6.in-berlin.de>
Content-Type: text/plain
Date: Sat, 24 Jun 2006 20:12:46 +0200
Message-Id: <1151172766.3181.75.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-24 at 19:45 +0200, Stefan Richter wrote:
> I wrote:
> > There were 63 instances of counting semaphores used for each hpsb_host.
> > All of them are now replaced by a single wait_queue.
> 
> After this and patch "ieee1394: dv1394: sem2mutex conversion", the 
> following semaphores remain in the ieee1394 subsystem:
> 
> highlevel.c:  hl_drivers_sem    (RW semaphore)
> nodemgr.c:    subsys.rwsem      (driver core's RW semaphores)
> raw1394.c:    fi->complete_sem  (completion semaphore)

Hi,

can this last one move to an actual completion? That would get rid of it
nicely ;)

Greetings,
   Arjan van de Ven

