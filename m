Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWIURBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWIURBR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 13:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWIURBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 13:01:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:22725 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751344AbWIURBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 13:01:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GsFopqA5HcYUwFQC3iD/PS3Z3wbSukWAQYGvYskoT80lOPKRuFnnowZrlgRNyhg+BjpyGfMxckRNTBAmnDvUtWR32fcf1wJyL56YjkL/DhVrGoRQqFRh+vbsf2yi9+CcMuRO2w44LpOxK6j6M/AIE5JchOKQwWB7wZXHSv12mPo=
Message-ID: <4512C54B.9060705@gmail.com>
Date: Fri, 22 Sep 2006 02:00:59 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: Andrew Lyon <andrew.lyon@gmail.com>
CC: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: JMicron 20360/20363 AHCI Controller much slower with 2.6.18
References: <f4527be0609210104p3c6c4933ke77d8372f6dd3848@mail.gmail.com>
In-Reply-To: <f4527be0609210104p3c6c4933ke77d8372f6dd3848@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lyon wrote:
> Hi,
> 
> I have a Gigabyte GA_965P_DS3 with Core 2 Duo CPU, wd raptor connected
> to onboard JMicron 20360/20363 AHCI Controller, with 2.6.18 the drive
> is very slow:
> 
> beast ~ # uname -a
> Linux beast 2.6.18 #1 SMP Wed Sep 20 15:04:24 BST 2006 i686 Intel(R) 
> Core(TM)2 C
> PU          6600  @ 2.40GHz GNU/Linux
> beast ~ # hdparm -t /dev/sda
> 
> /dev/sda:
> Timing buffered disk reads:  100 MB in  3.02 seconds =  33.10 MB/sec

Which IO scheduler are you using?  If you're using anticipatory or cfq, 
can you try deadline?

Thanks.

-- 
tejun
