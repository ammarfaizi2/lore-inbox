Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWFSNIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWFSNIx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 09:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWFSNIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 09:08:53 -0400
Received: from mail.timesys.com ([65.117.135.102]:34436 "EHLO
	postfix.timesys.com") by vger.kernel.org with ESMTP id S932440AbWFSNIw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 09:08:52 -0400
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and  
	dynamic HZ
From: Thomas Gleixner <tglx@timesys.com>
Reply-To: tglx@timesys.com
To: Con Kolivas <kernel@kolivas.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200606192305.17098.kernel@kolivas.org>
References: <1150643426.27073.17.camel@localhost.localdomain>
	 <200606192209.38403.kernel@kolivas.org>
	 <1150720304.27073.70.camel@localhost.localdomain>
	 <200606192305.17098.kernel@kolivas.org>
Content-Type: text/plain
Date: Mon, 19 Jun 2006 15:10:11 +0200
Message-Id: <1150722611.27073.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 23:05 +1000, Con Kolivas wrote:
> In clockevents.c 
> setup_global_clockevent and recalc_events call ret=setup_event()
> 
> and they act on ret but setup_event always returns 0
> 
> Was more planned for setup_event() ?

In a previous version we did interrupt setup in setup_event(), but it
turned out to be too much hassle to pull in the arch specific quirks via
extra function pointers.

So the return value is just a remainder.

	tglx


