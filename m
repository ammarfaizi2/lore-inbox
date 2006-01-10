Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWAJSp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWAJSp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWAJSp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:45:59 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:26007 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932187AbWAJSp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:45:58 -0500
Message-ID: <43C3E85B.5000902@wolfmountaingroup.com>
Date: Tue, 10 Jan 2006 10:01:15 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3F986.4090209@mbligh.org> <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org> <43C3E74D.7060309@wolfmountaingroup.com>
In-Reply-To: <43C3E74D.7060309@wolfmountaingroup.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

> Linus Torvalds wrote:
>
>> On Tue, 10 Jan 2006, Martin Bligh wrote:
>>
>>
>>> The non-1GB-aligned ones need to be disbarred when PAE is on, I think.
>>>
>>
>> Well, right now _all_ the non-3:1 cases need to be disbarred. I think 
>> we depend on the kernel mapping only ever being the _one_ last entry 
>> in the top-level page table, which is only true with the 3:1 mapping.
>>
>> But I didn't check.
>>
>>
>
>
> No. It works fine (or seems to) with 2:2 mapping. I've tested with 
> these extensively
> and am shipping products on the 1U appliances with 2:2 and I have 
> never seen any problems
> with 2.6.9-2.6.13.
>
> The only unpleasant side affect with 3:1 is user apps seem to rely on 
> swap space
> a little more than I like -- perhaps this is the side affect you are 
> referring to?
>
> RH ES uses 4:4 which is ideal and superior to this hack.
>
> Jeff
>
Take that back. I checked the build and 2:2 does not work correctly with 
highmem enabled. So
you may be correct. Highmem support is crap anyway and a 4:4 scheme is 
what this should have been
from the start. It's ok. The nice thing about Linux if you don't like 
what Linus is cooking in the kitchen,
you can add your own ingredients and make something else.

Jeff
