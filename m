Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWAJSl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWAJSl3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbWAJSl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:41:29 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:24215 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S1751019AbWAJSl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:41:28 -0500
Message-ID: <43C3E74D.7060309@wolfmountaingroup.com>
Date: Tue, 10 Jan 2006 09:56:45 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Jens Axboe <axboe@suse.de>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3F986.4090209@mbligh.org> <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Tue, 10 Jan 2006, Martin Bligh wrote:
>  
>
>>The non-1GB-aligned ones need to be disbarred when PAE is on, I think.
>>    
>>
>
>Well, right now _all_ the non-3:1 cases need to be disbarred. I think we 
>depend on the kernel mapping only ever being the _one_ last entry in the 
>top-level page table, which is only true with the 3:1 mapping.
>
>But I didn't check.
>  
>


No. It works fine (or seems to) with 2:2 mapping. I've tested with these 
extensively
and am shipping products on the 1U appliances with 2:2 and I have never 
seen any problems
with 2.6.9-2.6.13.

The only unpleasant side affect with 3:1 is user apps seem to rely on 
swap space
a little more than I like -- perhaps this is the side affect you are 
referring to?

RH ES uses 4:4 which is ideal and superior to this hack.

Jeff

>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

