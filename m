Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUH0PrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUH0PrC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUH0PnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:43:12 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:62102 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266227AbUH0PlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:41:23 -0400
Message-ID: <412F5624.7010506@seagha.com>
Date: Fri, 27 Aug 2004 17:41:24 +0200
From: Karl Vogel <karl.vogel@seagha.com>
User-Agent: Mozilla Thunderbird 0.7.1 (Windows/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1+patches: Still a memory leak with cdrecord
References: <412F4637.8080901@bio.ifi.lmu.de>
In-Reply-To: <412F4637.8080901@bio.ifi.lmu.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Steiner wrote:
> Karl Vogel wrote:
> 
>>I'm not sure, but this sounds a bit similar to a problem I am seeing.
>> Are you by any chance using the CFQ scheduler?! (elevator=cfq) If so, 
 >> give elevator=as or elevator=deadline a go.
> 
> I've no idea what the CFQ scheduler is :-) I'm not using anything like
> that on the kernel append line, so if it's not standard, then no, I'm
 > likely not using it...

Probably not. Anticipatory (as) scheduler is the default, so unless you 
specify elevator=cfq on the boot line (or are running a patched kernel), 
you will be using that.

You can look at the kernel boot messages to find out, or do the 
following in a shell after booting:

# dmesg|grep "io scheduler"


