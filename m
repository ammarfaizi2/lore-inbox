Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265842AbUA1JTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 04:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbUA1JTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 04:19:43 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:16654 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265842AbUA1JTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 04:19:42 -0500
Message-ID: <40178197.6060204@aitel.hist.no>
Date: Wed, 28 Jan 2004 10:32:07 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Alexander Nyberg <alexn@telia.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1 dual xeon
References: <20040124203646.A8709@animx.eu.org>	 <1074995006.5246.1.camel@localhost> <20040125083712.A9318@animx.eu.org>	 <20040127073801.GB9708@favonius> <1075223587.1173.5.camel@llhosts>
In-Reply-To: <1075223587.1173.5.camel@llhosts>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg wrote:

> But I can't see a reason for not dividing the different interrupt on
> different cpu's and letting them stay put. 

You want to spread the load, but that is hard to do without knowing
which interrupt sources are heavy and which are light.
Dividing them once might end up with keyboard & mouse interrupts
on one cpu and network+disk on another.  This is clearly imbalanced.

An irq balancing utility will fix this, by balancing based
on interrupt count.


> Maybe if you keep all
> interrupts on the same cpu the cache on the other ones will not have to
> be flushed often, which would be a good thing.
> 
> How would it be to maybe remove all interrupts from a cpu (except
> between cpu's) and have a few cpu's merely working with data and one "in
> control". Bad idea I guess as I haven't seen any such work.

Makes sense only if the amounts of interrupt work and other work matches
the division you make.  

Helge Hafting

