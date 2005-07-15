Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263374AbVGOW2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263374AbVGOW2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 18:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbVGOW2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 18:28:21 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:27609 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262111AbVGOW0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 18:26:54 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Mark Gross <mgross@linux.intel.com>
Cc: Dave Jones <davej@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
X-X-Sender: dlang@dlang.diginsite.com
Date: Fri, 15 Jul 2005 15:25:51 -0700 (PDT)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
In-Reply-To: <200507151447.46318.mgross@linux.intel.com>
Message-ID: <Pine.LNX.4.62.0507151524120.13813@qynat.qvtvafvgr.pbz>
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel>
 <9a8748490507141845162c0f19@mail.gmail.com> <20050715020912.GB22284@redhat.com>
 <200507151447.46318.mgross@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005, Mark Gross wrote:

> On Thursday 14 July 2005 19:09, Dave Jones wrote:
>> On Fri, Jul 15, 2005 at 03:45:28AM +0200, Jesper Juhl wrote:
>> >>> The problem is the process, not than the code.
>> >>> * The issues are too much ad-hock code flux without enough
>> >>> disciplined/formal regression testing and review.
>> >>
>> >> It's basically impossible to regression test swsusp except to release
>> >> it. Its success or failure depends on exactly the driver
>> >> combination/platform/BIOS version etc.  e.g. all drivers have to
>> >> cooperate and the particular bugs in your BIOS need to be worked
>> >> around etc. Since that is quite fragile regressions are common.
>> >>
>> >> However in some other cases I agree some more regression testing
>> >> before release would be nice. But that's not how Linux works.  Linux
>> >> does regression testing after release.
>> >
>> > And who says that couldn't change?
>> >
>> > In my oppinion it would be nice if Linus/Andrew had some basic
>> > regression tests they could run on kernels before releasing them.
>>
>> The problem is that this wouldn't cover the more painful problems
>> such as hardware specific problems.
>>
>> As Fedora kernel maintainer, I frequently get asked why peoples
>> sound cards stopped working when they did an update, or why
>> their system no longer boots, usually followed by a
>> "wasnt this update tested before it was released?"
>>
>> The bulk of all the regressions I see reported every time
>> I put out a kernel update rpm that rebases to a newer
>> upstream release are in drivers. Those just aren't going
>> to be caught by folks that don't have the hardware.
>
> This problem is the developer making driver changes without have the resources
> to test the changes on a enough of the hardware effected by his change, and
> therefore probubly shouldn't be making changes they cannot realisticaly test.
>
> What would be wrong in expecting the folks making the driver changes have some
> story on how they are validating there changes don't break existing working
> hardware?  I could probly be accomplished in open source with subsystem
> testing volenteers.

in that case you will have a lot of drivers that won't work becouse the 
rest of the kernel has changed and they haven't been changed to match.

do you have the resources to test a few hundred network cards, video 
cards, etc? if you do great, hope you can help out, if not why should you 
require other kernel folks to have resources that you don't have?

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
