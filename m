Return-Path: <linux-kernel-owner+w=401wt.eu-S1755129AbWL3Obx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129AbWL3Obx (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 09:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755114AbWL3Obx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 09:31:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50589 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbWL3Obw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 09:31:52 -0500
Message-ID: <4596784A.1060001@torque.net>
Date: Sat, 30 Dec 2006 09:31:38 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: Sumant Patro <sumantp@lsil.com>, James.Bottomley@SteelEye.com,
       akpm@osdl.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       neela.kolli@lsi.com, bo.yang@lsi.com, sumant.patro@lsi.com
Subject: Re: [Patch] scsi: megaraid_{mm,mbox}: init fix for kdump
References: <1167408137.4154.8.camel@dumbo> <20061229133741.441a5933.rdunlap@xenotime.net>
In-Reply-To: <20061229133741.441a5933.rdunlap@xenotime.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Fri, 29 Dec 2006 08:02:17 -0800 Sumant Patro wrote:
> 
> See Documentation/SubmittingPatches:
> Please include output of "diffstat -p1 -w70" so that we can easily see
> the scope of the changes.
> 
> and see Documentation/CodingStyle for comments below:
> 
> 
>> diff -uprN linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c
>> --- linux-2.6.orig/drivers/scsi/megaraid/megaraid_mbox.c 2006-12-28 09:56:04.000000000 -0800
>> +++ linux-2.6.new/drivers/scsi/megaraid/megaraid_mbox.c 2006-12-29 05:31:48.000000000 -0800
>> @@ -779,6 +780,22 @@ megaraid_init_mbox(adapter_t *adapter)
>>  		goto out_release_regions;
>>  	}
>>  
>> +	// initialize the mutual exclusion lock for the mailbox
>> +	spin_lock_init(&raid_dev->mailbox_lock);
> 
> Linux uses /*...*/ C89-style comments, not // C99 comments.

Randy
It is about time this absurd stipulation was dropped.
Are there any C compilers that can compile the linux
kernel and that don't accept both _standard_ comment styles?

Doug Gilbert
