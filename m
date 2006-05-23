Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWEWVkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWEWVkS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 17:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWEWVkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 17:40:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34508 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932304AbWEWVkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 17:40:16 -0400
Date: Tue, 23 May 2006 14:42:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, balbir@in.ibm.com
Subject: Re: [Patch 0/6] statistics infrastructure
Message-Id: <20060523144258.0938c4d3.akpm@osdl.org>
In-Reply-To: <44733F7B.9070009@de.ibm.com>
References: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
	<20060519092411.6b859b51.akpm@osdl.org>
	<44733F7B.9070009@de.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke <mp3@de.ibm.com> wrote:
>
> Andrew Morton wrote:
> > Martin Peschke <mp3@de.ibm.com> wrote:
> >> My patch series is a proposal for a generic implementation of statistics.
> > 
> > This uses debugfs for the user interface, but the
> > per-task-delay-accounting-*.patch series from Balbir creates an extensible
> > netlink-based system for passing instrumentation results back to userspace.
> > 
> > Can this code be converted to use those netlink interfaces, or is Balbir's
> > approach unsuitable, or hasn't it even been considered, or what?
> > 
> 
> Andrew,
> 
> taskstats, Balbir'r approach, is too specific and doesn't work for me.
> It is by design limited to per-task data.

OK.  They are pretty different things.

Balbir, do you see any sane way in which the APIs you've implemented can be
extended to cover this requirement?

> My statistics code is not limited to per-task statistics, but allows exploiters
> to have data been accumulated and been shown for whatever entity they need to,
> may it be for tasks, for SCSI disks, per adapter, per queue, per interface,
> for a device driver, etc.

OK.

> If you want me to change my code to use netlink anyway, I might be able to
> implement my own genetlink family. I haven't look at the details of that yet.
> 

Well, a debugfs interface _should_ be OK.  If not, why do we need debugfs?

Ho hum, hard.  Please send the patches again, let's take a closer look, see
if we can move them forward a bit.

