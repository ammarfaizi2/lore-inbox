Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUC1BJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 20:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbUC1BJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 20:09:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14263 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262050AbUC1BJy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 20:09:54 -0500
Message-ID: <406625D4.7090605@pobox.com>
Date: Sat, 27 Mar 2004 20:09:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: nickpiggin@yahoo.com.au, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com>	<40661049.1050004@yahoo.com.au>	<406611CA.3050804@pobox.com>	<406616EE.80301@pobox.com>	<4066191E.4040702@yahoo.com.au>	<40662108.40705@pobox.com> <20040327170257.24c82915.akpm@osdl.org>
In-Reply-To: <20040327170257.24c82915.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> TCQ-on-write for ATA disks is yummy because you don't really know what 
>> the heck the ATA disk is writing at the present time.  By the time the 
>> Linux disk scheduler gets around to deciding it has a nicely merged and 
>> scheduled set of requests, it may be totally wrong for the disk's IO 
>> scheduler.  TCQ gives the disk a lot more power when the disk integrates 
>> writes into its internal IO scheduling.
> 
> 
> Slightly beneficial for throughput, disastrous for latency.

If the disk is smart there are surely opportunities for latency 
optimization as well...


> It appears the only way we'll ever get this gross misdesign fixed is to add
> a latency test to winbench.

rotfl ;-)  True that...

"IOPs" are what make a lot of storage peeps excited these days, so they 
are being pushed in a low-latency direction anyway.

	Jeff



