Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVCKQYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVCKQYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 11:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVCKQYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 11:24:39 -0500
Received: from scilla.wseurope.com ([195.110.122.96]:16822 "EHLO
	corp.wseurope.com") by vger.kernel.org with ESMTP id S261160AbVCKQY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 11:24:26 -0500
From: Simone Piunno <simone.piunno@wseurope.com>
Organization: Wireless Solutions
To: Jens Axboe <axboe@suse.de>
Subject: Re: bonnie++ uninterruptible under heavy I/O load
Date: Fri, 11 Mar 2005 17:24:44 +0100
User-Agent: KMail/1.8
Cc: Fabio Coatti <fabio.coatti@wseurope.com>, Baruch Even <baruch@ev-en.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
References: <200503111208.20283.simone.piunno@wseurope.com> <200503111658.04499.simone.piunno@wseurope.com> <20050311160048.GM28188@suse.de>
In-Reply-To: <20050311160048.GM28188@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200503111724.44296.simone.piunno@wseurope.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 17:00, venerdì 11 marzo 2005, Jens Axboe ha scritto:

> > It was after running bonnie++.
>
> Are you sure? It lists only 190 commands run since it initialized,
> that's basically nothing.

Yes I'm sure!

Isn't this number the MAX value ever samplef for "Current # commands on 
controller"?  It doesn't seem to be the counter of how many commands were 
processed since start.

To doublecheck, I're run bonnie one more time.
This one was taken while bonnie was running:

cciss0: HP Smart Array 5i Controller
Board ID: 0x40800e11
Firmware Version: 2.56
IRQ: 18
Logical drives: 1
Current Q depth: 0
Current # commands on controller: 132
Max Q depth since init: 147
Max # commands on controller since init: 190
Max SG entries since init: 31

rereading the file, the only moving number was "Current # commands on 
controller", basically oscillating between 10 and 150.

> 6 was the highest depth, should not be enough to cause serious latency
> issues unless it was constantly at 6. 

As you see, after more runs Max Q raised to 147, but I'm sure it was 6 after 
that first run, and in that 1st run responsiveness was already sluggish.

Anyway, I wouldn't focus too much on CCISS, cause the only thing that's 
specific of this hardware is the long delay killing bonnie.  
Bad responsiveness has been found almost everywhere else.

-- 
Simone Piunno, chief architect
Wireless Solutions SPA - DADA group
Europe HQ, via Castiglione 25 Bologna
web:www.dada-ws.com tel:+39512966811 fax:+39512966800
