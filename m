Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbVJKVPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbVJKVPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 17:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVJKVPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 17:15:34 -0400
Received: from quark.didntduck.org ([69.55.226.66]:58091 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932222AbVJKVPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 17:15:34 -0400
Message-ID: <434C2B4A.7040309@didntduck.org>
Date: Tue, 11 Oct 2005 17:14:50 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alon Bar-Lev <alon.barlev@gmail.com>
CC: "Jonathan M. McCune" <jonmccune@cmu.edu>, linux-kernel@vger.kernel.org,
       Arvind Seshadri <arvinds@cs.cmu.edu>, Bryan Parno <parno@cmu.edu>
Subject: Re: using segmentation in the kernel
References: <434C1D60.2090901@cmu.edu> <434C2269.5090209@didntduck.org> <434C1F8E.6080405@gmail.com>
In-Reply-To: <434C1F8E.6080405@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alon Bar-Lev wrote:
> Brian Gerst wrote:
> 
>> Jonathan M. McCune wrote:
>>
>>> Hello,
>>>
>> Why send the kernel back to the 2.0 days?  There is no valid reason 
>> for doing this with they way x86 segmentation works, which is why it 
>> was done away with in 2.1.
>>
> 
> But with segmentation you can set code to be read-only, disallow 
> execution from stack, separate modules so that they will not affect 
> kernel and more...
> 
> The main problem with segmentation is that it is x86 specific...

Too much pain for for not enough gain.  Segments are not fine-grained 
enough to work well.  Look at the PaX and execshield hacks for 
userspace.  You are far better off working at the page-table level (RO 
and NX pages) which has the advantage of being portable.

--
				Brian Gerst
