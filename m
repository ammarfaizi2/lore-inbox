Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWJGQvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWJGQvV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 12:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWJGQvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 12:51:21 -0400
Received: from ns1.mvista.com ([63.81.120.158]:30700 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750801AbWJGQvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 12:51:20 -0400
Subject: Re: [PATCH 01/10] -mm: clocksource: increase initcall priority
From: Daniel Walker <dwalker@mvista.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
In-Reply-To: <87hcygqgl8.fsf@duaron.myhome.or.jp>
References: <20061006185439.667702000@mvista.com>
	 <20061006185456.261581000@mvista.com>  <87hcygqgl8.fsf@duaron.myhome.or.jp>
Content-Type: text/plain
Date: Sat, 07 Oct 2006 09:51:18 -0700
Message-Id: <1160239878.21411.3.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-10-08 at 00:40 +0900, OGAWA Hirofumi wrote:
> Daniel Walker <dwalker@mvista.com> writes:
> 
> > Index: linux-2.6.17/drivers/clocksource/acpi_pm.c
> > ===================================================================
> > --- linux-2.6.17.orig/drivers/clocksource/acpi_pm.c
> > +++ linux-2.6.17/drivers/clocksource/acpi_pm.c
> > @@ -174,4 +174,4 @@ pm_good:
> >  	return clocksource_register(&clocksource_acpi_pm);
> >  }
> >  
> > -module_init(init_acpi_pm_clocksource);
> > +postcore_initcall(init_acpi_pm_clocksource);
> 
> Current code is assumeing DECLARE_PCI_FIXUP_EARLY() is called before
> init_acpi_pm_clocksource().
> 
> We'll need to change it.

We can add a call to clocksource_rating_change() inside
acpi_pm_need_workaround(), are there deeper dependencies?

Daniel

