Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWJGSob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWJGSob (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 14:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWJGSoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 14:44:30 -0400
Received: from ns1.mvista.com ([63.81.120.158]:41469 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S932354AbWJGSoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 14:44:30 -0400
Subject: Re: [PATCH 01/10] -mm: clocksource: increase initcall priority
From: Daniel Walker <dwalker@mvista.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
In-Reply-To: <87lknsotnj.fsf@duaron.myhome.or.jp>
References: <20061006185439.667702000@mvista.com>
	 <20061006185456.261581000@mvista.com> <87hcygqgl8.fsf@duaron.myhome.or.jp>
	 <1160239878.21411.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <87d594qa4o.fsf@duaron.myhome.or.jp>  <87lknsotnj.fsf@duaron.myhome.or.jp>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 11:44:28 -0700
Message-Id: <1160246668.21411.12.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 03:41 +0900, OGAWA Hirofumi wrote:

> >>> 
> >>> We'll need to change it.
> >>
> >> We can add a call to clocksource_rating_change() inside
> >> acpi_pm_need_workaround(), are there deeper dependencies?
> >
> > There is no deeper dependencies.  If it's meaning
> > clocksource_reselect() in current git, it sounds good to me.
> 
> Ah, I was forgetting why I didn't before. If it's a buggy pmtmr, we'll
> get corrupted time until re-selecting the clocksource.
> 
> If anybody doesn't care this will be good with it. If not, we would
> need to back to old one. IIRC, John did it.

We could just reverse it, use the verified read function until we know
it's a good PM timer, then switch to the faster read function.

Daniel

