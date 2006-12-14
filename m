Return-Path: <linux-kernel-owner+w=401wt.eu-S932874AbWLNR02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932874AbWLNR02 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932875AbWLNR02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:26:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:41321 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874AbWLNR01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:26:27 -0500
Date: Thu, 14 Dec 2006 09:26:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
In-Reply-To: <Pine.LNX.4.61.0612141206500.6223@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.64.0612140924140.5718@woody.osdl.org>
References: <20061213195226.GA6736@kroah.com>  <Pine.LNX.4.64.0612131205360.5718@woody.osdl.org>
 <1166044471.11914.195.camel@localhost.localdomain>
 <Pine.LNX.4.61.0612132219480.32433@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0612131522310.5718@woody.osdl.org>
 <Pine.LNX.4.61.0612141206500.6223@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Dec 2006, Jan Engelhardt wrote:
> 
> I don't get you. The rtc module does something similar (RTC generates
> interrupts and notifies userspace about it)

The RTC module knows how to shut the interrupt up.

(And in many cases, timers are special. Timers, by design, are often "edge 
triggered" even in systems that have no other interrupts that work that 
way. Exactly because a timer is special. So the RTC module often knows 
that it doesn't need to do anything at all to shut it up, but even that 
is special per-device knowledge, that is NOT TRUE for any normal devices).


		Linus
