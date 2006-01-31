Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbWAaUWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbWAaUWY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 15:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWAaUWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 15:22:24 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:65248 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751455AbWAaUWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 15:22:23 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <43DFC648.4030404@s5r6.in-berlin.de>
Date: Tue, 31 Jan 2006 21:19:20 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jody McIntyre <scjody@modernduck.com>
CC: linux1394-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Ben Collins <ben.collins@ubuntu.com>
Subject: ieee1394/oui.db (was Re: [PATCH] ieee1394: allow building with absolute
 SUBDIRS path)
References: <1138234743.10202.3.camel@localhost> <20060131052101.GC9667@conscoop.ottawa.on.ca>
In-Reply-To: <20060131052101.GC9667@conscoop.ottawa.on.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (0.455) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jody McIntyre wrote:
> Does anyone else feel like killing oui.c?

I have no strong feelings for or against oui.db. It is nice to have the 
vendor names decoded in sysfs, although the footprint is considerable:

$ du oui.o ieee1394.ko
252K    oui.o
356K    ieee1394.ko

OTOH, nobody is forced to compile it in. And except for the Makefile 
patch and .gitignore patch which came in this month, oui.db does not 
impose a real maintenance burden. The fact that we are too lazy to 
update the db saves us work too. :-)

BTW, oui.db has 7048 entries but IEEE lists 8949 today. Either people 
vote oui.db off the island now, or I will submit an update.
-- 
Stefan Richter
-=====-=-==- ---= =====
http://arcgraph.de/sr/
