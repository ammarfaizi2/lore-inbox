Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWIINYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWIINYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 09:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWIINYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 09:24:25 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42979 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932170AbWIINYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 09:24:24 -0400
Message-ID: <4502C086.2080302@garzik.org>
Date: Sat, 09 Sep 2006 09:24:22 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Grzegorz Kulewski <kangur@polcom.net>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] linux/magic.h for magic numbers
References: <20060909110245.GA9617@havoc.gtf.org> <Pine.LNX.4.63.0609091453200.29522@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.63.0609091453200.29522@alpha.polcom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski wrote:
> On Sat, 9 Sep 2006, Jeff Garzik wrote:
>> An IRC discussion sparked a memory:  most filesystems really don't
>> need to put anything at all in include/linux.  Excluding API-ish
>> filesystems like procfs, just about the only filesystem symbols that
>> get exported outside of __KERNEL__ are the *_SUPER_MAGIC symbols,
>> and similar symbols.
>>
>> After seeing the useful attributes of linux/poison.h, I propose a
>> similar linux/magic.h.
> 
> But... if some patch changes this file (like adding new magic symbol) it 
> will cause large part of the kernel to rebuild without any good reason. No?

No :)

* The days when linux/fs.h included individual filesystem headers is 
long gone.  Only the filesystems themselves typically include the 
linux/foo_fs*.h files these days.

* It's not like we add new filesystems to the kernel very often.

	Jeff


