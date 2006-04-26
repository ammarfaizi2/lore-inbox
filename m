Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWDZRhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWDZRhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWDZRhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:37:15 -0400
Received: from smtp-out.google.com ([216.239.33.17]:5460 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932075AbWDZRhO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:37:14 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=gmiPfIXftjDCMXRhdZW/UgAMLUaCS8TgpOTi5StP/uKfxiK/4rii0zHckQiNJREjx
	o5oSF8uGg7yjXEY+dcWXA==
Message-ID: <444FAFB6.4070303@google.com>
Date: Wed, 26 Apr 2006 10:36:54 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@google.com>
CC: Ken Harrenstien <klh@google.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kernel-reviewers] a small code review (2414483) Automated g4
 rollback of changelist 2396062.
References: <444F0729.2020407@google.com> <444F0A94.70100@google.com> <6599ad830604252300m27db3d20j39beafbe09788824@mail.google.com> <444F1218.6020601@google.com> <6599ad830604252334yd6d933w5386dccb4af4b971@mail.google.com> <444F9777.9090704@google.com> <444F989B.3040900@google.com> <444F9E2B.40704@google.com> <444FA2BB.2070908@google.com> <Pine.LNX.4.56.0604261002430.4623@minbar.corp.google.com> <20060426173225.GB28519@google.com>
In-Reply-To: <20060426173225.GB28519@google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> On Wed, Apr 26, 2006 at 10:12:14AM -0700, Ken Harrenstien wrote:
> 
>>That doesn't work because IIRC it only reports the amount of memory
>>the kernel has been told (eg via "mem=") to manage in a certain sense,
>>not how much is actually physically available.
>>
>>The I2 netboot kernel would really REALLY like some exported /proc
>>values that accurately report physical memory (if nothing else, the
>>number of DIMMs and their sizes).  It has to figure this out in order
>>to install the proper kernel with proper LILO command-line args.
> 
> 
> The kernel can't really know how much memory is in the system without
> getting chipset-specific.
> 
> MTRR is a good way to hazard a guess, and will probably be right, but as
> you indicated, BIOS vendors have historically been REALLY bad about
> MTRRs.  Better now, but bad a few years ago.
> 
> SMBIOS (on our boards) *does* accurately report the number of DIMMS and
> their sizes (and more!).  But it only works on Google BIOS.

cc: linux-kernel
bcc: kernel-reviewers

Are you saying our e820 maps and srat tables are wrong? that's a little
worrying ...

M.
