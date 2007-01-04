Return-Path: <linux-kernel-owner+w=401wt.eu-S932146AbXADRy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbXADRy2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbXADRy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:54:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38518 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932146AbXADRy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:54:27 -0500
Message-ID: <459D3F4A.5070904@redhat.com>
Date: Thu, 04 Jan 2007 12:54:18 -0500
From: Peter Staubach <staubach@redhat.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061215)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Bill Davidsen <davidsen@tmr.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
References: <459CEA93.4000704@tls.msk.ru> <Pine.LNX.4.64.0701041242530.27899@blonde.wat.veritas.com> <459D290B.1040703@tmr.com> <Pine.LNX.4.64.0701041653250.12920@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0701041653250.12920@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 4 Jan 2007, Bill Davidsen wrote:
>   
>> In many cases the use of O_DIRECT is purely to avoid impact on cache used by
>> other applications. An application which writes a large quantity of data will
>> have less impact on other applications by using O_DIRECT, assuming that the
>> data will not be read from cache due to application pattern or the data being
>> much larger than physical memory.
>>     
>
> I see that as a good argument _not_ to allow O_DIRECT on tmpfs,
> which inevitably impacts cache, even if O_DIRECT were requested.
>
> But I'd also expect any app requesting O_DIRECT in that way, as a caring
> citizen, to fall back to going without O_DIRECT when it's not supported.

I suppose that one could also argue that the backing store for tmpfs
is the memory itself and thus, O_DIRECT could or should be supported.

    Thanx...

       ps
