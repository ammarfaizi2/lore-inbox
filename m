Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbVIAVV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbVIAVV0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbVIAVVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:21:24 -0400
Received: from smtpout.mac.com ([17.250.248.70]:30151 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751016AbVIAVVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:21:23 -0400
In-Reply-To: <Pine.LNX.4.61.0509011634200.3728@scrub.home>
References: <F989B1573A3A644BAB3920FBECA4D25A042B03A8@orsmsx407> <Pine.LNX.4.61.0509011104160.3728@scrub.home> <20050901134802.GA1753@tsunami.ccur.com> <Pine.LNX.4.61.0509011634200.3728@scrub.home>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <534B652C-E567-4086-9F17-DEE54A01081C@mac.com>
Cc: Joe Korty <joe.korty@ccur.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>, akpm@osdl.org,
       george@mvista.com, johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] A more general timeout specification
Date: Thu, 1 Sep 2005 17:20:51 -0400
To: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 1, 2005, at 11:18:52, Roman Zippel wrote:
> On Thu, 1 Sep 2005, Joe Korty wrote:
>> On Thu, Sep 01, 2005 at 11:19:51AM +0200, Roman Zippel wrote:
>>> You still didn't explain what's the point in choosing
>>> different clock sources for a _timeout_.
>>
>> Well, if CLOCK_REALTIME is set forward by a minute,
>> timers & timeout specified against that clock will expire
>> a minute earlier than expected.
>
> That just rather suggests that the pthread API is broken as usual.
> (No other possible user was mentioned so far.)

How about a hypothetical time-based event daemon.  I want to run
some jobs every 10 minutes that the system is running (not off or
suspended), I want to run other jobs every hour in real time, and
if one such timer expires while suspended, I want to run it
immediately to catch up.  The first suggests CLOCK_MONOTONIC, and
the second works better with CLOCK_REALTIME.

> So in practice it's easier to advance CLOCK_MONOTONIC/CLOCK_REALTIME
> equally and only apply time jumps to CLOCK_REALTIME.

I thought that's what he said, but maybe I'm just confused :-D.

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare



