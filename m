Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTEIW35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 18:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbTEIW34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 18:29:56 -0400
Received: from watch.techsource.com ([209.208.48.130]:32406 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S263552AbTEIW34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 18:29:56 -0400
Message-ID: <3EBC2FD7.2080007@techsource.com>
Date: Fri, 09 May 2003 18:46:47 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: hammer: MAP_32BIT
References: <3EBB5A44.7070704@redhat.com> <20030509092026.GA11012@averell> <16059.37067.925423.998433@gargle.gargle.HOWL> <20030509113845.GA4586@averell> <b9gr03$42n$1@cesium.transmeta.com> <3EBC0084.4090809@redhat.com> <3EBC15B5.4070604@zytor.com> <3EBC2164.6050605@redhat.com> <3EBC29A5.1050005@techsource.com> <3EBC2996.2040908@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



H. Peter Anvin wrote:
> Timothy Miller wrote:
> 
>>If your program is capable of handling an address with more than 32
>>bits, what point is there giving a hint?  Either your program can handle
>>64-bit pointers or it cannot.  Any program flexible enough to handle
>>either size dynamically would expend enough overhead checking that it
>>would be worse than if it just made a hard choice.
>>
> 
> 
> The purpose is that there is a slight task-switching speed advantage if
> the address is in the bottom 4 GB.  Since this affects every process,
> and most processes use very little TLS, this is worthwhile.
> 
> This is fundamentally due to a K8 design flaw.

Is there an explicit check somewhere for this?  Are the page tables laid 
out differently?

