Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWAJSjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWAJSjf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWAJSjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:39:35 -0500
Received: from dvhart.com ([64.146.134.43]:2689 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750936AbWAJSjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:39:35 -0500
Message-ID: <43C3FF66.7000004@mbligh.org>
Date: Tue, 10 Jan 2006 10:39:34 -0800
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jens Axboe <axboe@suse.de>, Byron Stanoszek <gandalf@winds.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2G memory split
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3F986.4090209@mbligh.org> <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601101028360.4939@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 10 Jan 2006, Martin Bligh wrote:
> 
>>The non-1GB-aligned ones need to be disbarred when PAE is on, I think.
> 
> 
> Well, right now _all_ the non-3:1 cases need to be disbarred. I think we 
> depend on the kernel mapping only ever being the _one_ last entry in the 
> top-level page table, which is only true with the 3:1 mapping.
> 
> But I didn't check.

I think it was OK as of 2.6.5 or so, unless something changed recently.
Used to work unless you had PAE on, and a non-aligned split ... I had 
that patch as a config option for a long time, as did SuSE, etc.

M.
