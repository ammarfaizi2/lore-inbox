Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbWD0Jh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWD0Jh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 05:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWD0Jh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 05:37:29 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:46598 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S965032AbWD0Jh2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 05:37:28 -0400
Message-ID: <445090D4.2070203@argo.co.il>
Date: Thu, 27 Apr 2006 12:37:24 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mark Lord <lkml@rtr.ca>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/scsi/sd.c: fix uninitialized variable in handling
 medium errors
References: <200604261627.29419.lkml@rtr.ca>	<1146092161.12914.3.camel@mulgrave.il.steeleye.com>	<20060426161444.423a8296.akpm@osdl.org>	<44500033.3010605@rtr.ca> <20060426163536.6f7bff77.akpm@osdl.org>
In-Reply-To: <20060426163536.6f7bff77.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2006 09:37:26.0956 (UTC) FILETIME=[32062EC0:01C669DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> block, I suspect.  My DVD trauma was IDE-induced.  Jens is mulling the
> problem - I'd suggest you coordinate with him.
>
> It would be a good thing to fix.
>
> It's moderately hard to test, though.  Easy enough for DVDs and CDs, but
> it's harder to take a marker pen to a hard drive.
>   
If it's in the block layer, perhaps using a device mapper error target 
can help in testing. One could write a table to map an entire partition 
to a logical volume, then replace it with a table that maps a few 
sectors to the error target.

-- 
error compiling committee.c: too many arguments to function

