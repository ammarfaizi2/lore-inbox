Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVBGFEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVBGFEq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 00:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVBGFEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 00:04:46 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:42593 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261352AbVBGFEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 00:04:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=pXxQoqU3MWqUfm1lAg2SnZgTl/Z5J9oEX30iBP2qVzXSdJEsjUGWiQD6iOkKbO2Y+Wtqf9ikXLXotORYvyvCyS1CE1gKjcJckwryKrjj1XeOw4HKf095MFLHrooAEIoS7fH7H11erfXOn6nhzs2VhqFseM5PoJTTRs4Hm5kZcmw=
Message-ID: <4206F6D9.6050700@gmail.com>
Date: Mon, 07 Feb 2005 14:04:25 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Tejun Heo <tj@home-tj.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 05/09] ide: map ide_task_ioctl() to ide_taskfile_ioctl()
References: <20050205021502.GA17767@htj.dyndns.org>	 <20050205021556.CFCE41326F9@htj.dyndns.org> <58cb370e050206103817d11145@mail.gmail.com>
In-Reply-To: <58cb370e050206103817d11145@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Sat,  5 Feb 2005 11:15:56 +0900 (KST), Tejun Heo <tj@home-tj.org> wrote:
> 
> 
>>-       int err = 0;
>>-       u8 args[7], *argbuf = args;
>>-       int argsize = 7;
>>+       u8 args[7];
>>+       ide_task_t task;
>>+       task_ioreg_t *regs = task.tfRegister;
> 
> 
> u8 *regs please
> 

  Sure.

> 
>>+       int ret;
> 
> 
> What is the reason for changing the name of variable
> (other than making the patch bigger ;) ?

  Heh, Heh, I thought I could get away with it.

  I'll restore it. :-)

> Please also read comments to patch #4.

  Thanks.

-- 
tejun

