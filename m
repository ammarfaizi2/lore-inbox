Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965093AbWECFLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965093AbWECFLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 01:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWECFLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 01:11:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:60214 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965093AbWECFLH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 01:11:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RmBuGKRCmYnTVGVo7kvjXYtYss2S0ueBjLI+We38decPHBI2aLv7XtX/Lcmn3xUgpvgLT3MYtgXA0nIFVNXD9If65sDssxDsgnPiFrx9xgkIhvcjXbwatHUqpv4sPk0nY09Eb6dMDOfOqiDQSxsNJV7j44O9tdd7WUdKMp76IHU=
Message-ID: <6934efce0605022211q7b265ef5o76faf27cd421dab5@mail.gmail.com>
Date: Tue, 2 May 2006 22:11:06 -0700
From: "Jared Hulbert" <jaredeh@gmail.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: [RFC] Advanced XIP File System
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <625fc13d0605021756v7a8e0d7p1e9d8e4c810bc092@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Accidentally replied just to Josh, sorry.  Included what was offline.

>>> From what I recall, XIP of the kernel off of MTD is limited to ARM.  I
>>> assume AXFS suffers the same restriction?
>>
>> I'm fairly certian it won't.  I don't see anything in the code (that
>> we aren't going to remove) that would cause that.  All it needs is
>> direct memory access to the volume.  I'll find out soon, I'm trying to
>> test it on a X86 UML system.
>>
>> The XIP awareness in the MTD isn't a requirement for XIP, it's a
>> requirement to XIP from flash you are going to write, erase or
>> otherwise mess with.
>
>So you're relying on the fact that the underlying flash chip won't
>change from the Read Array state?  What happens if someone tries to
>use AXFS on an MTD partition, which can cover only a portion of a
>chip.  That is a fairly common occurance for read-only root
>filesystems.  Other partitions (say JFFS2) on that chip will cause the
>chip state to change...

Right.  So that is exactly the case XIP Awareness is in the MTD to
fix, and it does so such that AXFS doesn't have to worry about it.
