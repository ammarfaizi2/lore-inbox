Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262788AbVEYFkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbVEYFkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 01:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVEYFkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 01:40:10 -0400
Received: from quark.didntduck.org ([69.55.226.66]:30624 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262788AbVEYFkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 01:40:05 -0400
Message-ID: <42941017.3090707@didntduck.org>
Date: Wed, 25 May 2005 01:41:43 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: van <van.wanless@eqware.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: File I/O from within a driver
References: <2005524221531.650853@Oz>
In-Reply-To: <2005524221531.650853@Oz>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

van wrote:
> Hi...
>  
> I am currently writing a driver for a hardware codec accelerator.  The calling application will open a media file, write to the codec driver, and read frames back from the codec driver.  My issue comes with the read of the media file.  The structure of media files is complex and I'd rather the calling application didn't need to have any knowledge of that structure.  But how can the driver do the necessary read() operations?
>  
> I could, for example, have the application pass an open file descriptor in to my driver via an ioctl() call; if I understand matters correctly, my driver could then call sys_read().  I've never done anything like that before, never expected to need to, and it doesn't feel right.
>  
> Can anyone suggest the *proper* way to accomplish this?
>  
> I am not a member the list list; I hit the weeklies pretty frequently, but I'd appreciate it any responders would CC me directly at van.wanless@eqware.net.   Thanks.
>

The best way is to mmap() the file into memory, then pass the address to 
the driver.

--
				Brian Gerst
