Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269233AbUI3AUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269233AbUI3AUN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 20:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUI3AUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 20:20:13 -0400
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:11213 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S269231AbUI3AR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 20:17:59 -0400
Message-ID: <415B50B4.6050801@blueyonder.co.uk>
Date: Thu, 30 Sep 2004 01:17:56 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.8 (X11/20040914)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alistair@devzero.co.uk
CC: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm4 and nvidia 1.0-6111
References: <415A6EE6.1090404@blueyonder.co.uk> <20040929171522.GA18579@taniwha.stupidest.org> <1096478939.1600.3.camel@krustophenia.net> <200409291907.12821.alistair@devzero.co.uk>
In-Reply-To: <200409291907.12821.alistair@devzero.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2004 00:18:21.0663 (UTC) FILETIME=[FE5C2EF0:01C4A682]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Wednesday 29 September 2004 18:28, you wrote:
> 
>>On Wed, 2004-09-29 at 13:15, Chris Wedgwood wrote:
>>
>>>On Wed, Sep 29, 2004 at 01:04:58PM -0400, Lee Revell wrote:
>>>
>>>>Isn't there an nvidia-linux mailing list?  This is really OT for
>>>>LKML.
>>>
>>>I had one for a while where I posted patches but it never gained much
>>>momentum.  Unless there is a sizable group of people who want this I
>>>don't see any need to resurrect it.
>>
>>OK, makes sense.  With so many people using the driver I guess it's just
>>easiest to deal with nvidia problems on LKML.
>>
>>Lee
>>
> 
> 
> Just about any out-of-kernel driver using Changed-API-X will be broken, free 
> or non-free. Something more general like linux-drivers or 
> linux-kernel-drivers would probably make more sense.
> 
> Sometimes changes in -mm even break in-kernel drivers; it's not really an 
> "NVIDIA problem" as such. I agree with Lee though; it's an unwritten rule 
> that you prefix a subject with [OT] when speaking about something which isn't 
> directly relevant to the kernel.
> 
> (By the way, if this breaks outside of -mm patches will appear for stable 
> kernels on http://minion.de/ as did with the 2.5 development tree.)
> 
So, in addition to the patches from 
http://00f.net/blogs/index.php/2004/09/07/nvidia_kernel_module_and_linux_2_6_9_mm 
  I've changed NV_REMAP_PAGE_RANGE to NV_REMAP_PFN_RANGE and 
remap_page_range to remap_pfn_range in nv-linux.h, nv.c, os-agp.c, and 
os-interface.c, the missing piece -- see below. I may get around to 
posting patches to the nvidia forum later today.

I'm not sure if I can divulge the name of my helper in case he gets 
showered by unwanted email, but a suggested additional change to 
nv-linux.h has fixed it.
#define NV_REMAP_PFN_RANGE(from, offset, x...) \
      remap_pfn_range(vma, from, ((offset)) >> PAGE_SHIFT), x)

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====
