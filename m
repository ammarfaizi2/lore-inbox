Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbTILW3m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTILW3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:29:42 -0400
Received: from gate.firmix.at ([80.109.18.208]:8334 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261647AbTILW3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:29:40 -0400
Subject: Re: [linux-2.4.0-test5] swsusp w/o swap fail...
From: Bernd Petrovitsch <bernd@firmix.at>
To: Patrick Mochel <mochel@osdl.org>
Cc: Daniel Blueman <daniel.blueman@gmx.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0309121509120.984-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0309121509120.984-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 13 Sep 2003 00:29:34 +0200
Message-Id: <1063405774.1195.26.camel@gimli.at.home>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-09-13 at 00:11, Patrick Mochel wrote:
> 
> On Fri, 12 Sep 2003, Daniel Blueman wrote:
> 
> > Clearly, software suspend needs a dependency on swapfiles being enabled.
> 
> Clearly, since it's expressed that way in the Kconfig file: 
> 
> config SOFTWARE_SUSPEND
>         bool "Software Suspend (EXPERIMENTAL)"
>         depends on EXPERIMENTAL && PM && SWAP
> 
> 
> Did you hand edit the .config file, or were you able to enable 
> SOFTWARE_SUSPEND w/o CONFIG_SWAP in one of the configurators? 

I had the same problem with a .config copied and `make oldconfig` from a
2.6.0-test4 kernel (and the -test4 compiled and was running).

I don't really know what's the problem, but CONFIG_ACPI_SLEEP=y selects
CONFIG_SOFTWARE_SUSPEND independent if it or CONFIG_SWAP is selected.
And it's somewhat confusing if one cannot turn off
CONFIG_SOFTWARE_SUSPEND (after enabling CONFIG_SWAP) via `make
menuconfig` even it is bool.
So the workaroung was to simply disable CONFIG_SLEEP. 

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

