Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWAJSp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWAJSp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWAJSp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:45:28 -0500
Received: from rtr.ca ([64.26.128.89]:41149 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751168AbWAJSp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:45:27 -0500
Message-ID: <43C400C4.2090504@rtr.ca>
Date: Tue, 10 Jan 2006 13:45:24 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3F986.4090209@mbligh.org> <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org> <43C3E74D.7060309@wolfmountaingroup.com>
In-Reply-To: <43C3E74D.7060309@wolfmountaingroup.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:
> Linus Torvalds wrote:
>> On Tue, 10 Jan 2006, Martin Bligh wrote:
>>> The non-1GB-aligned ones need to be disbarred when PAE is on, I think.
>> Well, right now _all_ the non-3:1 cases need to be disbarred. I think 
>> we depend on the kernel mapping only ever being the _one_ last entry 
>> in the top-level page table, which is only true with the 3:1 mapping.
>>
>> But I didn't check.
..
> 
> No. It works fine (or seems to) with 2:2 mapping. I've tested with these 
> extensively
..

The boundary for 2:2 with the current patch is 0x78000000, not 0x80000000.
It may still work, but nobody's checked yet.

cheers
