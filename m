Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932568AbWBQIqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbWBQIqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 03:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWBQIqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 03:46:09 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:54959 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932568AbWBQIqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 03:46:07 -0500
Date: Fri, 17 Feb 2006 00:46:05 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Grant Grundler <iod00d@hp.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>,
       Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Problems with MSI-X on ia64
Message-ID: <20060217084605.GG4523@taniwha.stupidest.org>
References: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net> <20060217075829.GB22451@esmail.cup.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217075829.GB22451@esmail.cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 11:58:29PM -0800, Grant Grundler wrote:

> The root cause is the use of u32 to describe a PCI resource "start".
> phys_addr needs to be "unsigned long". More details in Log entry
> below.

That won't always suffice.

I have machines at work that will place some PCI resources above the
4GB boundary even when booting in '32-bit OS' mode (there is a BIOS
option for this but no matter the setting some resources always end up
above 4GB).  I've heard from others they've also been hit by this
(with 64-bit kernels it's fine).  I guess it could be argued that it's
a BIOS bug, I'm not entirely sure what to thing,  Windows seems to
deal with it.
