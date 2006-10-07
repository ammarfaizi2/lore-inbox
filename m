Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbWJGTUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWJGTUB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 15:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWJGTUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 15:20:00 -0400
Received: from mail.parknet.jp ([210.171.160.80]:34572 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932784AbWJGTT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 15:19:59 -0400
X-AuthUser: hirofumi@parknet.jp
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [PATCH 01/10] -mm: clocksource: increase initcall priority
References: <20061006185439.667702000@mvista.com>
	<20061006185456.261581000@mvista.com>
	<87hcygqgl8.fsf@duaron.myhome.or.jp>
	<1160239878.21411.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	<87d594qa4o.fsf@duaron.myhome.or.jp>
	<87lknsotnj.fsf@duaron.myhome.or.jp>
	<1160246668.21411.12.camel@c-67-180-230-165.hsd1.ca.comcast.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 08 Oct 2006 04:19:52 +0900
In-Reply-To: <1160246668.21411.12.camel@c-67-180-230-165.hsd1.ca.comcast.net> (Daniel Walker's message of "Sat\, 07 Oct 2006 11\:44\:28 -0700")
Message-ID: <877izcorvr.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker <dwalker@mvista.com> writes:

> On Sun, 2006-10-08 at 03:41 +0900, OGAWA Hirofumi wrote:
>
>> >>> 
>> >>> We'll need to change it.
>> >>
>> >> We can add a call to clocksource_rating_change() inside
>> >> acpi_pm_need_workaround(), are there deeper dependencies?
>> >
>> > There is no deeper dependencies.  If it's meaning
>> > clocksource_reselect() in current git, it sounds good to me.
>> 
>> Ah, I was forgetting why I didn't before. If it's a buggy pmtmr, we'll
>> get corrupted time until re-selecting the clocksource.
>> 
>> If anybody doesn't care this will be good with it. If not, we would
>> need to back to old one. IIRC, John did it.
>
> We could just reverse it, use the verified read function until we know
> it's a good PM timer, then switch to the faster read function.

Yes, we did it in old timer code.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
