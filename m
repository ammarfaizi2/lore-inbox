Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWEEWh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWEEWh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 18:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWEEWh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 18:37:57 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:5043 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932398AbWEEWh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 18:37:56 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Jes Sorensen <jes@sgi.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, akpm@osdl.org, jeremy@sgi.com
Subject: Re: [PATCH] Move various PCI IDs to header file
Date: Sat, 06 May 2006 08:37:50 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <0jkn52lnu505eb26plf5o7buertimg2e6v@4ax.com>
References: <20060504180614.X88573@chenjesu.americas.sgi.com> <20060504173722.028c2b24.rdunlap@xenotime.net> <445AE690.5030700@sgi.com> <Pine.LNX.4.58.0605050926250.3161@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0605050926250.3161@shark.he.net>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2006 09:27:06 -0700 (PDT), "Randy.Dunlap" <rdunlap@xenotime.net> wrote:

>On Fri, 5 May 2006, Jes Sorensen wrote:
>
>> Randy.Dunlap wrote:
>> > On Thu, 4 May 2006 18:09:45 -0500 (CDT) Brent Casavant wrote:
>> >
>> >> Move various QLogic, Vitesse, and Intel storage
>> >> controller PCI IDs to the main header file.
>> >>
>> >> Signed-off-by: Brent Casavant <bcasavan@sgi.com>
>> >>
>> >> ---
>> >>
>> >> As suggested by Andrew Morton and Jes Sorenson.
>> >
>> > as compared to:
>> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=9b860b8c4bde5949b272968597d1426d53080532
>>
>> I guess Andrew and I should be blamed for that. I Andrew suggested
>> putting the IDs in the 'right place' and I took the right place as being
>> the pci_ids.h file.
>>
>> Can't say I agree with the recommendation, having them in pci_ids.h is
>> nice and clean and it allows one to go look through the list, instead
>> they now really become random hex values :( Brent's patch is a perfect
>> example of IDs being used in multiple places, ie. the qla1280 driver
>> and in the IOC4 driver, so the claim in that Documentation/ file doesn't
>> hold water.
>>
>> Anyway, if this is the new rule, then I guess it's back to using the
>> ugly patch :(
>
>FWIW, I'm not saying that I agree with the new rule, just that
>it's there/merged.

When I worked on pci_ids.h cleanup last year I didn't get a clear 
idea of whether moving all #defines to the one header file was 
desired.  Last I looked there were heaps of them scattered all 
over.  Is there a preferred model for placing these #defines?

Grant.
