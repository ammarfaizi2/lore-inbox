Return-Path: <linux-kernel-owner+w=401wt.eu-S1161269AbXAHXTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbXAHXTH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161288AbXAHXTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:19:07 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46320 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161271AbXAHXTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:19:04 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Yinghai Lu <yinghai.lu@amd.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, discuss@x86-64.org
Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when check_timer fails.
References: <5986589C150B2F49A46483AC44C7BCA490733F@ssvlexmb2.amd.com>
	<86802c440701022223q418bd141qf4de8ab149bf144b@mail.gmail.com>
	<20070108005556.GA2542@melchior.yamamaya.is-a-geek.org>
	<Pine.LNX.4.64.0701071708240.3661@woody.osdl.org>
	<m1lkkdikmn.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hcv1ikfj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d55pikbc.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xgdijmb.fsf_-_@ebiederm.dsl.xmission.com>
	<20070108202105.GB6167@stusta.de>
	<m1k5zxgplv.fsf@ebiederm.dsl.xmission.com>
	<20070108223355.GI6167@stusta.de>
Date: Mon, 08 Jan 2007 16:18:33 -0700
In-Reply-To: <20070108223355.GI6167@stusta.de> (Adrian Bunk's message of "Mon,
	8 Jan 2007 23:33:55 +0100")
Message-ID: <m1bql9gl9y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Mon, Jan 08, 2007 at 02:45:00PM -0700, Eric W. Biederman wrote:
>> Adrian Bunk <bunk@stusta.de> writes:
>
> We just got a completely different bug reported that was confirmed to be 
> caused by Andi's patch:
>    AMD64/ATI : timer is running twice as fast as it should [1]

Odd. I didn't think Andi's code worked well enough that we could hit
anything but the default trust the BIOS case.  I guess someone had
the right hardware to perform that miracle.

>> I really don't care how we do it, or in what timeframe.  But what I have
>> posted is the only way I can see of making it better, than what we had
>> in 2.6.19.
>>...
>
> My whole point is that for 2.6.20, we can live with simply reverting 
> Andi's commit.
>
> What to do for 2.6.21 is a completely different story.

That is where I figured we were when we first hit this bug.

I have always found the ways of stable tree maintainers to be
mysterious.  Sometimes holding back code with minimal risk sometimes
insisting we cleanup things instead of reverting things.

So I have just decided to write the code and let other people figure
out when it should be merged :)  And of course when my code has
problems to address them.

Eric
