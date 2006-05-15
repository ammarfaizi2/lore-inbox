Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWEOXtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWEOXtm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWEOXtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:49:42 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:59347 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750821AbWEOXtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:49:41 -0400
Message-ID: <44691392.2030906@garzik.org>
Date: Mon, 15 May 2006 19:49:38 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060515182919.GA16070@irc.pl> <4468CBC7.2030900@garzik.org> <44690F91.2070206@gmail.com>
In-Reply-To: <44690F91.2070206@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
>> Tomasz Torcz wrote:
>>> On Mon, May 15, 2006 at 01:00:06PM -0400, Jeff Garzik wrote:
>>>> After much development and review, I merged a massive pile of libata
>>>> patches from Tejun Heo and Albert Lee.  This update contains the
>>>> following major libata
>>>
>>>   Any plans to merge http://home-tj.org/wiki/index.php/Sil_m15w ? Or
>>> maybe it's merged already?
>>>   Seagate firmware update seems to be available only for OEMs, so this
>>> quirk is pretty helpful for end users.
>>
>> Its a question of staging.  This still lives in the 'sii-m15w' branch 
>> of libata-dev.git, but if we throw too many _classes_ of changes into 
>> the same big lump, then it becomes much more difficult to discern 
>> which changes caused which failures.
>>
>> Since sata_sil has seen several changes, and since the sii-m15w 
>> problems are so difficult to diagnose properly, its easier to separate 
>> that out.
> 
> Are you planning on merging sil_m15w workaround?

Yes, but after 2.6.18.


> FYI, from the first time it was submitted (last summer) till 2.6.16, it 
> took very little effort to maintain it.  The current big update would 
> necessitate some changes to it but I don't think it will be too much 
> work.  My experience says m15w doesn't add too much maintenance overhead.

Its actively maintained in the 'sii-m15w' branch of libata-dev.git.


> Also, what's the merge plan for hotplug/PM?  Together into 2.6.18?  Or 
> are we looking further down?

Hotplug is reasonable for 2.6.18, but after that its getting a bit much. 
  We need to have some reasonable testing points in the midst of all 
this development :)  I'm happy to maintain an upstream-2.6.19 branch for 
such things, though.  I use tiered branches anyway.

	Jeff



