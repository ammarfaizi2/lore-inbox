Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWFUDyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWFUDyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 23:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWFUDyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 23:54:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47551 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750807AbWFUDyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 23:54:33 -0400
Date: Tue, 20 Jun 2006 20:54:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mark Lord <lkml@rtr.ca>
Cc: js@linuxtv.org, pavel@ucw.cz, p.lundkvist@telia.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl
Subject: Re: [PATCH] Page writeback broken after resume: wb_timer lost
Message-Id: <20060620205415.d808ace9.akpm@osdl.org>
In-Reply-To: <4498BF51.5090204@rtr.ca>
References: <20060520130326.GA6092@localhost>
	<20060520103728.6f3b3798.akpm@osdl.org>
	<20060520225018.GC8490@elf.ucw.cz>
	<20060520171244.4399bc54.akpm@osdl.org>
	<20060616212410.GA6821@linuxtv.org>
	<4496C5AC.3030809@rtr.ca>
	<4498BF51.5090204@rtr.ca>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 23:38:57 -0400
Mark Lord <lkml@rtr.ca> wrote:

> > I just gave it a try here.  With or without a suspend/resume cycle after 
> > boot,
> > the "sync" time is much quicker.  But the Dirty count in /proc/meminfo
> > still shows very huge (eg. 600MB) values that never really get smaller
> > until I type "sync".  But that subsequent "sync" only takes a couple
> > of seconds now, rather than 10-20 seconds like before.
> ..
> 
> Yup, behaviour is *definitely* much better now.  I'm not sure why
> the /proc/meminfo "Dirty" count lags behind reality, but the disk
> is being kept much more up-to-date than without this patch.

Are you able to come up with a foolproof set of steps which would allow the
laggy-dirtiness to be reproduced by yours truly?
