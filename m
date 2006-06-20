Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWFTJa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWFTJa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWFTJa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:30:28 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:29364 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030206AbWFTJa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:30:27 -0400
Date: Tue, 20 Jun 2006 10:30:16 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org,
       len.brown@intel.com, linux-acpi@vger.kernel.org
Subject: Re: [Ubuntu PATCH] acpi: Add IBM R60E laptop to proc-idle blacklist
Message-ID: <20060620093016.GA27807@srcf.ucam.org>
References: <4491BC6B.5000704@oracle.com> <20060619203333.5e897ead.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619203333.5e897ead.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:33:33PM -0700, Andrew Morton wrote:
> > +	{ set_max_cstate, "IBM ThinkPad R40e", {
> > +	  DMI_MATCH(DMI_BIOS_VENDOR, "IBM"),
> > +	  DMI_MATCH(DMI_BIOS_VERSION, "1SET70WW") }, (void*)1},

> It seems that every R40e in the world is in that table.
> 
> Can/should we wildcard it?  From my reading of dmi_check_system(), we can use
> "" in place of the "1SET..." string and it'll dtrt?

Wouldn't that result in every machine with "IBM" as the BIOS vendor 
having their maximum c-state limited?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
