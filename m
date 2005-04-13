Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVDMKoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVDMKoU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVDMKoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:44:19 -0400
Received: from mail.avantwave.com ([210.17.210.210]:47788 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S261300AbVDMKn6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:43:58 -0400
Message-ID: <425CF7DB.4000407@haha.com>
Date: Wed, 13 Apr 2005 18:43:39 +0800
From: Tomko <tomko@haha.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>, linux-kernel@vger.kernel.org
Subject: Re: Why system call need to copy the date from the userspace before
 using it
References: <425C9E55.6010607@haha.com> <20050413102916.GS4965@lug-owl.de>
In-Reply-To: <20050413102916.GS4965@lug-owl.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ,
Thank you for your reply, can i ask some more question?

Inside the system call , the kernel often copy the data by calling 
copy_from_user() rather than just using strcpy(), is it because the 
memory mapping in kenel space is different from user space?  for example 
, now user program want to pass a pointer *a to kernel space , is it 
true that *a seems means address 0xb000 to user space but actually it is 
at 0xc000 at kernel space?

Thx a lot,
TOM

Jan-Benedict Glaw wrote:

>On Wed, 2005-04-13 12:21:41 +0800, Tomko <tomko@haha.com>
>wrote in message <425C9E55.6010607@haha.com>:
>  
>
>>While i am reading the source code of the linux system call , i find 
>>that the system call need to call copy_from_user() to copy the data from 
>>user space to kernel space before using it . Why not use it directly as 
>>the system call has got the address ?  Furthermore , how to distinguish 
>>between user space and kernel space ?
>>    
>>
>
>Think about the memory access. The page that contains the data could be
>swapped out, so the kernel isn't allowed to just access it, because it's
>not there.
>
>MfG, JBG
>
>  
>

