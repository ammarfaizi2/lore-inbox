Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUBVTrr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 14:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbUBVTrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 14:47:47 -0500
Received: from terminus.zytor.com ([63.209.29.3]:5778 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S261733AbUBVTrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 14:47:45 -0500
Message-ID: <40390759.2020201@zytor.com>
Date: Sun, 22 Feb 2004 11:47:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040105
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BOOT_CS
References: <c16rdh$gtk$1@terminus.zytor.com> <m1znbbjgfz.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1znbbjgfz.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> hpa@zytor.com (H. Peter Anvin) writes:
> 
>>Anyone happen to know of any legitimate reason not to reload %cs in
>>head.S?  
> 
> Other than the fact it is strongly rude and error prone to depend on
> the contents of a global descriptor table you did not setup?
> 

We already do that, as you might have noticed (we set all the data 
registers to __BOOT_DS; CS is the only that is changed.)

> 
> That is almost nice.  Care to export where the bottom of the page
> tables or even better where the bottom of the kernel is for those
> folks who want to place their ramdisk as low in memory as possible?
> 

The problem is that you don't know until it's too late, since it can 
depend on dynamic factors.  This is part of why your insistence of 
putting the ramdisk in the "most incorrect" position is simply wrong.

	-hpa
