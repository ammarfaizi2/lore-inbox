Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUEQMhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUEQMhi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 08:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUEQMhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 08:37:38 -0400
Received: from zork.zork.net ([64.81.246.102]:45457 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261162AbUEQMhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 08:37:36 -0400
To: Andi Kleen <ak@suse.de>
Cc: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: i810 AGP fails to initialise (was Re: 2.6.6-mm2)
References: <20040513032736.40651f8e.akpm@osdl.org>
	<6usme4v66s.fsf@zork.zork.net> <20040513135308.GA2622@redhat.com>
	<20040513155841.6022e7b0.ak@suse.de> <6ulljwtoge.fsf@zork.zork.net>
	<20040513174110.5b397d84.ak@suse.de> <6u8yfvsbd4.fsf@zork.zork.net>
	<6uk6zeow52.fsf@zork.zork.net> <6u65avmo97.fsf@zork.zork.net>
	<20040517100159.GC4903@wotan.suse.de> <6ulljrl3gb.fsf@zork.zork.net>
	<20040517134651.5444eb54.ak@suse.de>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>, davej@redhat.com,  akpm@osdl.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 17 May 2004 13:37:30 +0100
In-Reply-To: <20040517134651.5444eb54.ak@suse.de> (Andi Kleen's message of
 "Mon, 17 May 2004 13:46:51 +0200")
Message-ID: <6ubrknkz5h.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Mon, 17 May 2004 12:04:36 +0100
> Sean Neakums <sneakums@zork.net> wrote:
>
>> Andi Kleen <ak@suse.de> writes:
>> 
>> > On Mon, May 17, 2004 at 09:49:56AM +0100, Sean Neakums wrote:
>> >> Sean Neakums <sneakums@zork.net> writes:
>> >> 
>> >> > Sean Neakums <sneakums@zork.net> writes:
>> >> >
>> >> >> Andi Kleen <ak@suse.de> writes:
>> >> >>
>> >> >>> Sean, can you double check that when you compile the AGP driver as module
>> >> >>> that the 7124 PCI ID appears in modinfo intel-agp ? 
>> >> >>> And does the module also refuse to load ? 
>> >> >>
>> >> >> I rebuilt with agpgart, intel-agp and i810 as modules, modprobed them,
>> >> >> and it works.
>> >> >
>> >> > I just realised that I probably forgot to reapply the patch before
>> >> > doing this test.  Will check Monday.  Sorry about this.
>> >> 
>> >> Below is modinfo output.  The module loads but doesn't initialise the
>> >> AGP.
>> >
>> > Someone else reported that it worked modular at least. When you apply
>> > the following patch what output do you get in the kernel log when you
>> > load the module?
>> 
>>   Linux agpgart interface v0.100 (c) Dave Jones
>>   agp_intel_init
>>   agp_intel_probe device 7124
>>   no cap
>
> Thanks for testing.
>
> Ok. This patch should fix it then. Revert the debug patch first. 

This did the trick.  Also applied it to 2.6.6-mm3, built static, works
fine there also.

