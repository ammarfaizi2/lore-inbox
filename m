Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWGHAOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWGHAOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbWGHAOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:14:51 -0400
Received: from xenotime.net ([66.160.160.81]:41450 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932432AbWGHAOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:14:50 -0400
Date: Fri, 7 Jul 2006 17:17:36 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, davej@codemonkey.org.uk
Subject: Re: [PATCH] PCIE: create sysfs directory on first use
Message-Id: <20060707171736.b07bc25e.rdunlap@xenotime.net>
In-Reply-To: <20060707171015.688e4011.akpm@osdl.org>
References: <20060707165238.337c7a4a.rdunlap@xenotime.net>
	<20060707171015.688e4011.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 17:10:15 -0700 Andrew Morton wrote:

> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> >
> > +			if (!pcie_dev_registered)
> > +				pcie_port_bus_register();
> > +
> 
> Wonderful.  You're forced to drop all error checking on the floor because
> pcie_port_bus_register() assumes that nobody could possibly ever be
> interested in actually checking for errors.
> 
> What happens if the bus_register() fails and the driver cheerily blunders
> along assuming that pcie_port_bus_type is registered?  Incomprehensible lkml
> oops reports, I'm suspecting..
> 
> Let's start stamping this out.  Could I please ask that you first prepare a
> patch which fixes pcie_port_bus_register() (and mark it __must_check) and
> then let's actually, like, check for errors?

Sure, will do.

And will make changes that Valdis mentioned.

---
~Randy
