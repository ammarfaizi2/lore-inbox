Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbWJUW10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWJUW10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 18:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbWJUW10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 18:27:26 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:20454 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161129AbWJUW10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 18:27:26 -0400
Subject: Re: [PATCH] Add include/linux/freezer.h and move definitions from
	sched.h
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>,
       suspend2-devel <suspend2-devel@lists.suspend2.net>
In-Reply-To: <200610211541.19050.rjw@sisk.pl>
References: <1161433266.7644.7.camel@nigel.suspend2.net>
	 <200610211541.19050.rjw@sisk.pl>
Content-Type: text/plain
Date: Sun, 22 Oct 2006 08:27:21 +1000
Message-Id: <1161469641.17061.18.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2006-10-21 at 15:41 +0200, Rafael J. Wysocki wrote:
> On Saturday, 21 October 2006 14:21, Nigel Cunningham wrote:
> > Move process freezing functions from include/linux/sched.h to freezer.h,
> 
> Hm, I'd rather move them to suspend.h.  Is there any reason for introducing
> yet another header file?

Suspend.h sounds reasonable. I picked freezer.h because I thought it
made the purpose of the #include simple and crystal clear, and doesn't
pull in other dependencies (my freezer.h depends on nothing else, where
as suspend.h already depends on:

#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
#include <asm/suspend.h>
#endif
#include <linux/swap.h>
#include <linux/notifier.h>
#include <linux/init.h>
#include <linux/pm.h>

That said, suspend.h isn't anything like sched.h itself :)

Nigel

