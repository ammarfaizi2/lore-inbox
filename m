Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbTLCT4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 14:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265126AbTLCT4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 14:56:41 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:37292 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265125AbTLCT4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:56:39 -0500
Date: Wed, 3 Dec 2003 11:56:31 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andre Tomt <lkml@tomt.net>
Cc: linux-kernel@vger.kernel.org, Ethan Weinstein <lists@stinkfoot.org>
Subject: Re: HT apparently not detected properly on 2.4.23
Message-ID: <20031203195631.GC29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Andre Tomt <lkml@tomt.net>, linux-kernel@vger.kernel.org,
	Ethan Weinstein <lists@stinkfoot.org>
References: <3FCE2F8E.90104@stinkfoot.org> <1070480450.15415.85.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070480450.15415.85.camel@slurv.pasop.tomt.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 08:40:51PM +0100, Andre Tomt wrote:
> On Wed, 2003-12-03 at 19:46, Ethan Weinstein wrote:
> > Hi,
> > 
> > With 2.4.22, my Supermicro X5DPL-iGM-O (E7501 chipset) with 2 
> > xeons@2.4ghz and hypertherading enabled shows 4 cpu's in 
> > /proc/cpuinfo|proc/interrupts, with:
> > CONFIG_ACPI=y
> > CONFIG_ACPI_HT_ONLY=y
> > The same config with 2.4.23 only shows 2 cpus, even with:
> > CONFIG_NR_CPUS=4
> 
> This may be the known problem about CONFIG_NR_CPU's not working properly
> in all cases. Try up'ing it to 32.

Depending on the logical addressing of your processors, CONFIG_NR_CPUS=8 may
work in this case too.

Some processors/motherboards logically address the CPUs other that 0-3 if
there are 4 processors.

Currently CONFIG_NR_CPUS needs to be big enough to hold the largest logical
processor number.
