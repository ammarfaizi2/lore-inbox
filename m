Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTEOCqz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 22:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTEOCqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 22:46:55 -0400
Received: from air-2.osdl.org ([65.172.181.6]:177 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263765AbTEOCqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 22:46:50 -0400
Date: Wed, 14 May 2003 20:00:02 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
In-Reply-To: <Pine.LNX.4.50.0305142243440.19782-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0305141956530.9816-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, Zwane Mwaikambo wrote:

> On Wed, 14 May 2003, Patrick Mochel wrote:
> 
> > Interesting. This is yet more proof that system-level devices cannot be
> > treated as common, everyday devices. Sure, it's nice to see them show up
> > in sysfs with little overhead, and very nice not to have to work about
> > them during shutdown or power transitions. But there are just too many
> > special cases (like getting the ordering right ;) that you have to worry
> > about.
> > 
> > So, what do we do with them? 
> 
> Does the PIC shutdown callback get called _just_ before acpi_power_off?

It may or may not be. It depends on which order it gets registered in, 
which is arbitrary (*). One can enable DEBUG in drivers/base/power.c and 
crank up the console log level to see the order that devices get shutdown 
in on their system. 


	-pat

(*) - Ok, we can control the registration via link order, but that's 
something we'll be tweaking until our dying days in absence of a good 
solution. 

