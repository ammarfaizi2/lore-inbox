Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbTITWXN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 18:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbTITWXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 18:23:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62414 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262002AbTITWXL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 18:23:11 -0400
Message-ID: <3F6CD341.40104@pobox.com>
Date: Sat, 20 Sep 2003 18:22:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
References: <200309131101.h8DB1WNd021570@harpo.it.uu.se>	 <1063476275.8702.35.camel@dhcp23.swansea.linux.org.uk>	 <20030913184934.GB10047@gtf.org> <20030913190131.GD10047@gtf.org>	 <20030915073445.GC27105@suse.de> <20030916194955.GC5987@gtf.org>	 <20030916195515.GC906@suse.de>  <3F6C9C55.6050608@pobox.com> <1064096170.23121.3.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1064096170.23121.3.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sad, 2003-09-20 at 19:28, Jeff Garzik wrote:
> 
>>sg needs some modifications -- for example it errors out instead of 
>>sleeps on queue full -- but sounds good to me.
> 
> 
> Is that an error and change in behaviour ?


No and yes.  :)

Current sg breaks the Unix model of write(2)... you shouldn't error out 
if the queue will "probably" become available again.

	Jeff



