Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbULORqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbULORqL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 12:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbULORqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 12:46:11 -0500
Received: from [194.90.79.130] ([194.90.79.130]:25867 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S262414AbULORqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:46:01 -0500
Message-ID: <41C07854.7000603@argo.co.il>
Date: Wed, 15 Dec 2004 19:45:56 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@istop.com>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com> <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu> <41ACE816.50104@argo.co.il> <200412031707.46114.phillips@istop.com>
In-Reply-To: <200412031707.46114.phillips@istop.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2004 17:45:59.0104 (UTC) FILETIME=[EFB58400:01C4E2CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>Hi Avi,
>
>On Tuesday 30 November 2004 16:37, Avi Kivity wrote:
>  
>
>>The situation with userspace filesystems is:
>>
>>  some process allocates memory, blocking on kswapd as memory is full
>>  kswapd calls userspace filesystem to free memory
>>  userspace filesystem calls kernel, which allocates memory and blocks
>>on kswapd
>>  eventually all processes in the system block on kswapd
>>
>>I have observed (and fixed) this on a real system.
>>    
>>
>
>What was your fix?
>
>  
>
(with apologies for the long delay)

See the thread at http://lkml.org/lkml/2004/7/26/68. basically allow the 
userspace filesystem process to access behave like kswapd allocation-wise.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

