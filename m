Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWFXRrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWFXRrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 13:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWFXRrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 13:47:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:26006 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750941AbWFXRrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 13:47:12 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <449D7A53.4080605@s5r6.in-berlin.de>
Date: Sat, 24 Jun 2006 19:45:55 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2.6.17-mm1 4/3] ieee1394: convert ieee1394_transactions
 from semaphores to waitqueue
References: <449BEBFB.60302@s5r6.in-berlin.de> <200606230904.k5N94Al3005245@shell0.pdx.osdl.net>  <30866.1151072338@warthog.cambridge.redhat.com> <tkrat.df6845846c72176e@s5r6.in-berlin.de> <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de> <tkrat.e74b06c4105348f6@s5r6.in-berlin.de> <tkrat.2ff7b57397a5a37e@s5r6.in-berlin.de> <tkrat.3f9c07538e381afd@s5r6.in-berlin.de>
In-Reply-To: <tkrat.3f9c07538e381afd@s5r6.in-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.349) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
> There were 63 instances of counting semaphores used for each hpsb_host.
> All of them are now replaced by a single wait_queue.

After this and patch "ieee1394: dv1394: sem2mutex conversion", the 
following semaphores remain in the ieee1394 subsystem:

highlevel.c:  hl_drivers_sem    (RW semaphore)
nodemgr.c:    subsys.rwsem      (driver core's RW semaphores)
raw1394.c:    fi->complete_sem  (completion semaphore)
-- 
Stefan Richter
-=====-=-==- -==- ==---
http://arcgraph.de/sr/
