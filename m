Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVDBS1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVDBS1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 13:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDBS1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 13:27:05 -0500
Received: from quark.didntduck.org ([69.55.226.66]:22196 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S261176AbVDBS04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 13:26:56 -0500
Message-ID: <424EE489.4040900@didntduck.org>
Date: Sat, 02 Apr 2005 13:29:29 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.2-1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ooyama eiichi <ooyama@tritech.co.jp>
CC: cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: kernel stack size
References: <20050403.024634.88477140.ooyama@tritech.co.jp>	<20050402175345.GA28710@taniwha.stupidest.org> <20050403.031542.23015132.ooyama@tritech.co.jp>
In-Reply-To: <20050403.031542.23015132.ooyama@tritech.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ooyama eiichi wrote:
> Thanks for your reply.
> 
> 
>>On Sun, Apr 03, 2005 at 02:46:34AM +0900, ooyama eiichi wrote:
>>
>>
>>>How can I know the rest size of the kernel stack.
>>
>>you can't in a platfork-independant way
> 
> 
> in i386 and ia64.
> 
> 
>>>(in my kernel driver)
>>
>>*why* do you want to do this?
>>
> 
> 
> because my driver hungs the machine by an certain ioctl.
> and it seems to me there is no bad in the code correspond to 
> the ioctl, except for that it is using large auto variables.
> (some functions are useing ~1KB autos)

That's your problem.  Use kmalloc instead of large local variables.

--
				Brian Gerst
