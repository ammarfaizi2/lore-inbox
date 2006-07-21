Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWGUNrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWGUNrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 09:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWGUNrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 09:47:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750731AbWGUNrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 09:47:52 -0400
Date: Fri, 21 Jul 2006 06:41:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Auke Kok <auke-jan.h.kok@intel.com>
Cc: pavel@ucw.cz, auke-jan.h.kok@intel.com, cramerj@intel.com,
       john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: e1000: "fix" it on thinkpad x60 / eeprom checksum read fails
Message-Id: <20060721064105.aa960acd.akpm@osdl.org>
In-Reply-To: <44BFBE9F.7070600@intel.com>
References: <20060721005832.GA1889@elf.ucw.cz>
	<44BFADA6.6090909@intel.com>
	<20060720170758.GA9938@atrey.karlin.mff.cuni.cz>
	<44BFBE9F.7070600@intel.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2006 10:34:23 -0700
Auke Kok <auke-jan.h.kok@intel.com> wrote:

> > Okay, perhaps this should be inserted as a comment into the driver,
> > and printk should be fixed to point at this explanation?
> > 
> > Can't we enable the driver with the bad checksum, then read the _real_
> > data?
> 
> no.
> 
> We're working on a solution where we make sure that the PHY is physically 
> turned on properly before we read the EEPROM, which would be the proper fix. 
> It's completely not acceptable to run when the EEPROM checksum fails - you 
> might even be running with the wrong MAC address, or worse. Lets fix this the 
> right way instead.

A printk which helps the user to understand all this saga would be very nice.
