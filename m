Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUGHPVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUGHPVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUGHPVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:21:01 -0400
Received: from mail.kroah.org ([69.55.234.183]:15590 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263709AbUGHPUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:20:48 -0400
Date: Thu, 8 Jul 2004 08:12:10 -0700
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net
Subject: Re: [Pcihpd-discuss] [PATCH] 2.6 PCI Hotplug: receive PPC64 EEH events
Message-ID: <20040708151210.GA12854@kroah.com>
References: <20040707155907.G21634@forte.austin.ibm.com> <20040707211656.GA4105@kroah.com> <20040707164739.I21634@forte.austin.ibm.com> <20040708052603.GA548@kroah.com> <20040708100433.K21634@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708100433.K21634@forte.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 10:04:33AM -0500, linas@austin.ibm.com wrote:
> On Wed, Jul 07, 2004 at 10:26:04PM -0700, Greg KH wrote:
> > On Wed, Jul 07, 2004 at 04:47:39PM -0500, linas@austin.ibm.com wrote:
> > 
> > > ===== drivers/pci/hotplug/rpaphp.h 1.9 vs edited =====
> > > +extern void init_eeh_handler (void);
> > > +extern void exit_eeh_handler (void);
> > 
> > This belongs in the eeh header file, not the rpaphp.h file.
> 
> But these are implemented in rpaphp_pci.c and are called 
> in rpaphp_core.c.  Perchance a different function name, such as
> init_rpaphp_eeh_handler() be better?

Ah, yes, see I didn't even catch that :)

They should start with "rpaphp" as they are global symbols.

thanks,

greg k-h
