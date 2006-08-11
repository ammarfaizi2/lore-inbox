Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWHKSzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWHKSzr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 14:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWHKSzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 14:55:47 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:18837 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1750827AbWHKSzq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 14:55:46 -0400
Message-ID: <44DCC49C.3020304@namesys.com>
Date: Fri, 11 Aug 2006 11:55:40 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nate Diller <nate.diller@gmail.com>
CC: Christoph Hellwig <hch@infradead.org>,
       Alexander Zarochentsev <zam@namesys.com>, Andrew Morton <akpm@osdl.org>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: partial reiser4 review comments
References: <20060803001741.4ee9ff72.akpm@osdl.org>	 <20060803142644.GC20405@infradead.org>	 <200608061838.35004.zam@namesys.com>	 <20060809085946.GA6177@infradead.org> <44D9A86F.3010304@namesys.com> <5c49b0ed0608101131h55f1505eo44b78603e2e8d3c2@mail.gmail.com>
In-Reply-To: <5c49b0ed0608101131h55f1505eo44b78603e2e8d3c2@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller wrote:

> On 8/9/06, Hans Reiser <reiser@namesys.com> wrote:
>
>> Christoph Hellwig wrote:
>>
>> > I must admit that standalone code snipplet doesn't really tell me a
>> lot.
>> >
>> >Do you mean the possibility to pass around a filesystem-defined
>> structure
>> >to multiple allocator calls?  I'm pretty sure can add that, I though it
>> >would be useful multiple times in the past but always found ways around
>> >it.
>> >
>> >
>> >
>> Assuming I understand your discussion, I see two ways to go, one is to
>> pass around fs specific state and continue to call into the FS many
>> times, and the other is to instead provide the fs with helper functions
>> that accomplish readahead calculation, page allocation, etc., and let
>> the FS keep its state naturally without having to preserve it in some fs
>> defined structure.  The second approach would be cleaner code design,
>> that would also ease cross-os porting of filesystems, in my view.
>
>
> the second approach is the one i was heading towards with my
> unfinished a_ops patches.  *please* won't someone pay me to do that
> work...
>
> NATE
>
>
You might describe it in a paragraph or so instead of just mentioning
it.....;-)
