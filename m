Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbWEOXck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWEOXck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWEOXcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:32:39 -0400
Received: from wx-out-0102.google.com ([66.249.82.198]:11784 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750772AbWEOXci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:32:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=uAs3Ju7ATxtX7YEsDzq8cxl7DY5Q5Aa1ZP+msp6nvzDV0YLF9/jPF9GXMxRjdryvPOeSk9nAt6QRm//YJRyNUgcrI8DiO5hjsUPXUyVJ4SlevlfEFVXeDX3gb8yx9FThFs2VjBcofXFGJSXsW2/+Ups3Ch0M7L26NaRTgVkOjsw=
Message-ID: <44690F91.2070206@gmail.com>
Date: Tue, 16 May 2006 08:32:33 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFT] major libata update
References: <20060515170006.GA29555@havoc.gtf.org> <20060515182919.GA16070@irc.pl> <4468CBC7.2030900@garzik.org>
In-Reply-To: <4468CBC7.2030900@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tomasz Torcz wrote:
>> On Mon, May 15, 2006 at 01:00:06PM -0400, Jeff Garzik wrote:
>>> After much development and review, I merged a massive pile of libata
>>> patches from Tejun Heo and Albert Lee.  This update contains the
>>> following major libata
>>
>>   Any plans to merge http://home-tj.org/wiki/index.php/Sil_m15w ? Or
>> maybe it's merged already?
>>   Seagate firmware update seems to be available only for OEMs, so this
>> quirk is pretty helpful for end users.
> 
> Its a question of staging.  This still lives in the 'sii-m15w' branch of 
> libata-dev.git, but if we throw too many _classes_ of changes into the 
> same big lump, then it becomes much more difficult to discern which 
> changes caused which failures.
> 
> Since sata_sil has seen several changes, and since the sii-m15w problems 
> are so difficult to diagnose properly, its easier to separate that out.

Are you planning on merging sil_m15w workaround?

FYI, from the first time it was submitted (last summer) till 2.6.16, it 
took very little effort to maintain it.  The current big update would 
necessitate some changes to it but I don't think it will be too much 
work.  My experience says m15w doesn't add too much maintenance overhead.

Also, what's the merge plan for hotplug/PM?  Together into 2.6.18?  Or 
are we looking further down?

-- 
tejun
