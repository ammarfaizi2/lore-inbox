Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTFYSCN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 14:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTFYSCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 14:02:13 -0400
Received: from dm2-55.slc.aros.net ([66.219.220.55]:24247 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S264884AbTFYSCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 14:02:04 -0400
Message-ID: <3EF9E6EA.6050901@aros.net>
Date: Wed, 25 Jun 2003 12:16:10 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl
 UI
References: <3EF94672.3030201@aros.net> <20030625001950.16bbb688.akpm@digeo.com> <3EF9C192.7000206@aros.net> <20030625165513.A20328@infradead.org> <3EF9DE23.2080806@aros.net> <20030625184423.A29537@infradead.org>
In-Reply-To: <20030625184423.A29537@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Wed, Jun 25, 2003 at 11:38:43AM -0600, Lou Langholtz wrote:
>  
>
>>Yes. To be fair though, the binary (and the driver too) was broken on 
>>linux 2.5 kernels long before I even proposed any changes to the nbd 
>>driver. I'm trying to fix that.
>>    
>>
>Hey, I didn't say changing the interface is wrong.  But if possible
>do it in a way that the new userspace can still support the old kernel
>driver.
>
Agreed! Will do, but how???

>>NBD_SET_SOCK. That'd tell nbd-tool that the nbd driver thinks something 
>>about the ioctl was invalid but not what. I wanted to return EDEPRECATED 
>>instead but I haven't found that errno yet. I could overload an errno 
>>but that seems ugly too. Or the driver could have a NBD_GET_VERSION 
>>ioctl. Is there precedence for that? I haven't come accross it yet.
>>    
>>
>
>That's one choice.  At least md and device mapper do that.
>  
>
Cool! I'll take a look at these. Is this the prefered way then? There's 
probably a lot of need for this generally speaking. Thought about using 
/proc for this too. And then sysfs is gaining favor so maybe in there? 
Any preference?

