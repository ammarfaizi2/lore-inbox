Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbVIAPQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbVIAPQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 11:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbVIAPQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 11:16:22 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56511 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030192AbVIAPQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 11:16:21 -0400
To: ncunningham@cyclades.com
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Pavel Machek <pavel@ucw.cz>,
       Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: reboot vs poweroff (was: Linux 2.6.13)
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>
	<1125557333.12996.76.camel@localhost>
	<Pine.SOC.4.61.0509011030430.3232@math.ut.ee>
	<4316F4E3.4030302@drzeus.cx> <1125578897.4785.23.camel@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 01 Sep 2005 09:15:00 -0600
In-Reply-To: <1125578897.4785.23.camel@localhost> (Nigel Cunningham's
 message of "Thu, 01 Sep 2005 22:48:17 +1000")
Message-ID: <m1fysoq0p7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> writes:

> On Thu, 2005-09-01 at 22:32, Pierre Ossman wrote:
>> Meelis Roos wrote:
>> > 
>> > It's OK then - I'm not using any suspend and I had a problem that my
>> > machine powered down instead of reboot. The patch that went into 2.6.13
>> > after rc7 fixed it for me. So the current tree is OK for me and if it's
>> > OK for you too after suspend2 changes then this case can probably be
>> > closed.
>> > 
>> 
>> I'm still having problems with this patch. Both swsusp and swsusp2 are
>> affected. Perhaps the fix Nigel did needs to be done to swsusp aswell?
>
> Yes, it does need modifying. I'll leave it to Pavel to do that though as
> he's more familiar with the intricacies of that code than I am.

Are suspend and suspend2 not calling kernel_power_off()?

I am not certain about that code path but I worked hard in the lead
up to 2.6.13 to get everyone on the same page so we did not have
strange reboot issues on one code path and not on another.

It is possible that the code path in suspend is so strange I did not
recognize it.  How do you initiate a S4 power off?

I can understand suspend2 having problems as it isn't merged but suspend
is merged isn't it?

Hmm.  Looking at that bug report it specifies 2.6.11.  Does this
problem really happen in 2.6.13?

Eric
