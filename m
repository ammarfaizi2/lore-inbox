Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945924AbWBDI6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945924AbWBDI6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 03:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945937AbWBDI6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 03:58:18 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:27277 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1945924AbWBDI6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 03:58:17 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43E46BC5.7090301@s5r6.in-berlin.de>
Date: Sat, 04 Feb 2006 09:54:29 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ben Collins <bcollins@ubuntu.com>, linux1394-user@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>
Subject: Re: ieee1394/oui.db (was Re: [PATCH] ieee1394: allow building with
 absolute SUBDIRS path)
References: <1138234743.10202.3.camel@localhost> <20060131052101.GC9667@conscoop.ottawa.on.ca> <43DFC648.4030404@s5r6.in-berlin.de> <1138739715.4456.302.camel@grayson>
In-Reply-To: <1138739715.4456.302.camel@grayson>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.469) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote on 2006-01-31:
> On Tue, 2006-01-31 at 21:19 +0100, Stefan Richter wrote:
>>Jody McIntyre wrote:
>>>Does anyone else feel like killing oui.c?
>>
>>I have no strong feelings for or against oui.db. It is nice to have the 
>>vendor names decoded in sysfs, although the footprint is considerable:
>>
>>$ du oui.o ieee1394.ko
>>252K    oui.o
>>356K    ieee1394.ko
>>
>>OTOH, nobody is forced to compile it in. And except for the Makefile 
>>patch and .gitignore patch which came in this month, oui.db does not 
>>impose a real maintenance burden. The fact that we are too lazy to 
>>update the db saves us work too. :-)
>>
>>BTW, oui.db has 7048 entries but IEEE lists 8949 today. Either people 
>>vote oui.db off the island now, or I will submit an update.
> 
> I vote update it. I really think something like OUI needs to be part of
> the kernel lib/ though. Lots of things, like ethernet and bluetooth can
> use it. No one really does though.

Yes, drivers/ieee1394/ is the wrong place for oui.db. In case oui.db was 
not killed by then, I will submit patches to move oui.db to lib/ later 
this month.
-- 
Stefan Richter
-=====-=-==- --=- --=--
http://arcgraph.de/sr/
