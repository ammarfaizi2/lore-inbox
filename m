Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWH1Qsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWH1Qsr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWH1Qsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:48:47 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:50059 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751200AbWH1Qsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:48:46 -0400
Subject: Re: [PATCH] maximum latency tracking infrastructure (version 3)
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu,
       jesse.barnes@intel.com, dwalker@mvista.com
In-Reply-To: <20060828163531.GA8257@rhlx01.fht-esslingen.de>
References: <1156780080.3034.207.camel@laptopd505.fenrus.org>
	 <20060828161145.GA25161@rhlx01.fht-esslingen.de>
	 <44F3178F.8010508@linux.intel.com>
	 <20060828163531.GA8257@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Aug 2006 18:48:19 +0200
Message-Id: <1156783699.3034.223.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Another question is how one would do callback processing in idle handler:
> one could figure out the idle mode (latency) in advance and *then* call
> only all those idle callbacks that have more stringent requirements
> than the currently calculated idle mode's latency (and then calculate
> the idle mode again based on the current time after all those callbacks??),
> or one could just unconditionally call all idle handlers and then figure out
> idle length and go to sleep. Which one is better?


I'm not sure about either actually. Well if it's just to refill stuff
etc then I would just call all. After all it may save interrupts and
early wakeups if you do this, so there's a power advantage to be gained.

