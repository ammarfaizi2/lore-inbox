Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263467AbUGHPFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbUGHPFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263626AbUGHPFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:05:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:14526 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263467AbUGHPFg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:05:36 -0400
Date: Thu, 8 Jul 2004 10:04:33 -0500
From: linas@austin.ibm.com
To: Greg KH <greg@kroah.com>
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [PATCH] 2.6 PCI Hotplug: receive PPC64 EEH events
Message-ID: <20040708100433.K21634@forte.austin.ibm.com>
References: <20040707155907.G21634@forte.austin.ibm.com> <20040707211656.GA4105@kroah.com> <20040707164739.I21634@forte.austin.ibm.com> <20040708052603.GA548@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040708052603.GA548@kroah.com>; from greg@kroah.com on Wed, Jul 07, 2004 at 10:26:04PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 10:26:04PM -0700, Greg KH wrote:
> On Wed, Jul 07, 2004 at 04:47:39PM -0500, linas@austin.ibm.com wrote:
> 
> > ===== drivers/pci/hotplug/rpaphp.h 1.9 vs edited =====
> > +extern void init_eeh_handler (void);
> > +extern void exit_eeh_handler (void);
> 
> This belongs in the eeh header file, not the rpaphp.h file.

But these are implemented in rpaphp_pci.c and are called 
in rpaphp_core.c.  Perchance a different function name, such as
init_rpaphp_eeh_handler() be better?

> > +	// pci_scan_child_bus(child_bus);
> 
> And the reason you are commenting out this function is...

Due to a mistake.

--linas
