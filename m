Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTEOLuJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 07:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTEOLuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 07:50:09 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:4527 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263971AbTEOLuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 07:50:08 -0400
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305141956530.9816-100000@cherise>
References: <Pine.LNX.4.44.0305141956530.9816-100000@cherise>
Content-Type: text/plain
Message-Id: <1053000155.605.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 15 May 2003 14:02:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-15 at 05:00, Patrick Mochel wrote:
> On Wed, 14 May 2003, Zwane Mwaikambo wrote:
> 
> > On Wed, 14 May 2003, Patrick Mochel wrote:
> > 
> > > Interesting. This is yet more proof that system-level devices cannot be
> > > treated as common, everyday devices. Sure, it's nice to see them show up
> > > in sysfs with little overhead, and very nice not to have to work about
> > > them during shutdown or power transitions. But there are just too many
> > > special cases (like getting the ordering right ;) that you have to worry
> > > about.
> > > 
> > > So, what do we do with them? 
> > 
> > Does the PIC shutdown callback get called _just_ before acpi_power_off?
> 
> It may or may not be. It depends on which order it gets registered in, 
> which is arbitrary (*). One can enable DEBUG in drivers/base/power.c and 
> crank up the console log level to see the order that devices get shutdown 
> in on their system. 

OK, I've changed "#undef DEBUG" to "#define DEBUG" in
drivers/base/power.c, but during shutdown, I can see no extra debug
messages. What am I doing wrong?

