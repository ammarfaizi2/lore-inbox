Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWHIUMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWHIUMv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWHIUMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:12:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751348AbWHIUMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:12:50 -0400
Date: Wed, 9 Aug 2006 13:12:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend
 to disk on i386
Message-Id: <20060809131232.75a260e1.akpm@osdl.org>
In-Reply-To: <200608092201.42885.rjw@sisk.pl>
References: <200608091426.31762.rjw@sisk.pl>
	<20060809123052.GB3808@elf.ucw.cz>
	<200608092201.42885.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2006 22:01:42 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Wednesday 09 August 2006 14:30, Pavel Machek wrote:
> > Hi!
> > > 
> > > It looks like the CMOS clock gets corrupted during the suspend to disk
> > > on i386.  I've observed this on 2 different boxes.  Moreover, one of them is
> > > AMD64-based and the x86_64 kernel doesn't have this problem on it.
> > > 
> > > Also, I've done some tests that indicate the corruption doesn't occur before
> > > saving the suspend image.  It rather happens when the box is powered off
> > > or rebooted (tested both cases).
> > > 
> > > Unfortunately, I have no more time to debug it further right now.
> > 
> > Do you have Linus' "please corrupt my cmos for debuggin" hack enabled?
> 
> Well, I know nothing about that. ;-)
> 

CONFIG_PM_TRACE=y will scrog your CMOS clock each time you suspend.
