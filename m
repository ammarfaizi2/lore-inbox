Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751865AbWAERiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865AbWAERiF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbWAERiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 12:38:05 -0500
Received: from linux.us.dell.com ([143.166.224.162]:16848 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S1751865AbWAERiC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 12:38:02 -0500
Date: Thu, 5 Jan 2006 11:37:40 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Alex Williamson <alex.williamson@hp.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ia64@vger.kernel.org,
       ak@suse.de, openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15 1/2] ia64: use i386 dmi_scan.c
Message-ID: <20060105173740.GA20650@lists.us.dell.com>
References: <20060104221627.GA26064@lists.us.dell.com> <1136414164.6198.36.camel@localhost.localdomain> <20060104232944.GA32250@lists.us.dell.com> <200601050941.15915.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601050941.15915.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 09:41:15AM -0700, Bjorn Helgaas wrote:
> The DMI scan looks like it's done in try_init_smbios().  But
> try_init_acpi() is done first.  Since every ia64 machine has
> ACPI, I would think try_init_acpi() should be sufficient.
> 
> Or do you have a machine that doesn't supply the SPMI
> table used by try_init_acpi()?

This system (Dell PowerEdge 7250, very very similar to an Intel 4-way
Itanium2 server) doesn't have an SPMI table, but it does have the IPMI
information in the SMBIOS table.

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
