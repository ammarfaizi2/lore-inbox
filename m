Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030374AbVIAVKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030374AbVIAVKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbVIAVKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:10:25 -0400
Received: from [203.171.93.254] ([203.171.93.254]:31375 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1030374AbVIAVKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:10:25 -0400
Subject: Re: reboot vs poweroff (was: Linux 2.6.13)
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, Pavel Machek <pavel@ucw.cz>,
       Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <m1fysoq0p7.fsf@ebiederm.dsl.xmission.com>
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>
	 <1125557333.12996.76.camel@localhost>
	 <Pine.SOC.4.61.0509011030430.3232@math.ut.ee> <4316F4E3.4030302@drzeus.cx>
	 <1125578897.4785.23.camel@localhost>
	 <m1fysoq0p7.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1125608946.4785.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 02 Sep 2005 07:09:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-09-02 at 01:15, Eric W. Biederman wrote:
> Nigel Cunningham <ncunningham@cyclades.com> writes:
> 
> > On Thu, 2005-09-01 at 22:32, Pierre Ossman wrote:
> >> Meelis Roos wrote:
> >> > 
> >> > It's OK then - I'm not using any suspend and I had a problem that my
> >> > machine powered down instead of reboot. The patch that went into 2.6.13
> >> > after rc7 fixed it for me. So the current tree is OK for me and if it's
> >> > OK for you too after suspend2 changes then this case can probably be
> >> > closed.
> >> > 
> >> 
> >> I'm still having problems with this patch. Both swsusp and swsusp2 are
> >> affected. Perhaps the fix Nigel did needs to be done to swsusp aswell?
> >
> > Yes, it does need modifying. I'll leave it to Pavel to do that though as
> > he's more familiar with the intricacies of that code than I am.
> 
> Are suspend and suspend2 not calling kernel_power_off()?

They are/weren't calling pm_ops->prepare if we're using poweroff or
reboot rather than entering S3 or S4.

> I am not certain about that code path but I worked hard in the lead
> up to 2.6.13 to get everyone on the same page so we did not have
> strange reboot issues on one code path and not on another.
> 
> It is possible that the code path in suspend is so strange I did not
> recognize it.  How do you initiate a S4 power off?
> 
> I can understand suspend2 having problems as it isn't merged but suspend
> is merged isn't it?

You're fine. It's just that we were both working around the problem
before, and don't need to now.

Regards,

Nigel

> Hmm.  Looking at that bug report it specifies 2.6.11.  Does this
> problem really happen in 2.6.13?
> 
> Eric
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

