Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVECSpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVECSpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 14:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVECSpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 14:45:53 -0400
Received: from quark.didntduck.org ([69.55.226.66]:32424 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261576AbVECSoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 14:44:13 -0400
Message-ID: <4277C6A4.3070409@didntduck.org>
Date: Tue, 03 May 2005 14:44:52 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: Rick Warner <rick@microway.com>, linux-kernel@vger.kernel.org
Subject: Re: zImage on 2.6?
References: <20050503012951.GA10459@animx.eu.org> <200505031206.09245.rick@microway.com> <20050503164012.GE11937@animx.eu.org>
In-Reply-To: <20050503164012.GE11937@animx.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wakko Warner wrote:
> Please keep me CCd
> 
> Rick Warner wrote:
> 
>>On Monday 02 May 2005 09:29 pm, Wakko Warner wrote:
>>
>>>Is it possible to use zImage on 2.6 kernels or is bzImage required?
>>
>>Why do you need the zImage anyway?  Maybe there is another way around the 
>>problem you are having.  Can you post what you are trying to do (end goal) ?
> 
> 
> This is a little project I'm doing to beable to load a system onto a hard
> drive.  The linux system is short lived by design and will run out of a
> tmpfs root populated by various tgz files found either on CDs or a USB
> stick.
> 
> My goal (which I realize may not be achivable nor is it important in the
> long run) is to get the kernel and the initrd onto a single floppy disk
> (Currently, I'm ~80kb too large for this).
> 
> I decided (remembering 2.2 days and prior when zImage was normally used) to
> try zImage to see what happened.  I was going to compare the size of the
> resulting images.  That's when I hit the problem.
> 
> I understand that upx can compress the kernel better and I also remember
> hearing about utilizing bzip2 as the compressor for the kernel and initrd
> images.
> 
> As far as my question, it still stands.  Is bzImage required (i386/x86) for
> a 2.6 kernel?
> 

More or less yes.  As you're finding out, it's very difficult to build a 
functioning 2.6 kernel that fits the size requirements of the zImage 
format.  Really, the zImage format is not needed anymore.  It was only 
kept around because a small number of ancient BIOSes failed to load the 
bzImage format with the now defunct floppy boot block.  There is no size 
difference in the resulting zImage or bzImage, only the load address is 
different.

--
				Brian Gerst
