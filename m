Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269334AbUICQfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269334AbUICQfK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUICQfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:35:10 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:63617 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S269334AbUICQfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:35:03 -0400
Message-ID: <41389CDA.5060609@rtr.ca>
Date: Fri, 03 Sep 2004 12:33:30 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: md RAID over SATA performance
References: <1094169937l.17931l.0l@werewolf.able.es>
In-Reply-To: <1094169937l.17931l.0l@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even with hardware RAID the numbers I see are not often
much better than this.

Unless O_DIRECT is used (hdparm --direct), in which case they
immediately jump to a level that is more limited by the PCI
and memory speeds of the system.

Eg.  205Mbytes/sec for a 4-drive RAID0 over 64-bit/66Mhz PCI.

I guess the page_cache overhead is rather substantial
for the simple read-a-sequential-block test.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
