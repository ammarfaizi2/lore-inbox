Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVALGih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVALGih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 01:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVALGih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 01:38:37 -0500
Received: from fmr17.intel.com ([134.134.136.16]:17370 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261249AbVALGie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 01:38:34 -0500
Subject: Re: [PATCH]change 'struct device' -> platform_data to firmware_data
From: Li Shaohua <shaohua.li@intel.com>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Greg KH <greg@kroah.com>, Deepak Saxena <dsaxena@plexity.net>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       rmk@arm.linux.org.uk
In-Reply-To: <37B1A29C-6460-11D9-8591-000393DBC2E8@freescale.com>
References: <1105506942.3081.6.camel@sli10-desk.sh.intel.com>
	 <37B1A29C-6460-11D9-8591-000393DBC2E8@freescale.com>
Content-Type: text/plain
Message-Id: <1105511849.3081.15.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 12 Jan 2005 14:37:29 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-12 at 14:07, Kumar Gala wrote:
> Embedded PPC has followed in ARMs footsteps with the use of 
> platform_data for board specific information to be passed to drivers.   
> The plan is to grow its use in embedded PPC. It would seem introducing 
> a new field for ACPI information would be the least painful solution.
I'll be happy to the solution too.

> Can some clarify what kind of information ACPI needs.  I'm asking 
> because firmware_data does not seem any more clear to me.
Most devices have an ACPI counterpart in ACPI based system. We plan to
make 'platform_data' point to an ACPI device, which will enables us to
utilize some ACPI features.

Thanks,
Shaohua
> 
> Also, we should really probably be a bit more specific in 
> Documentation/driver-model/device.txt once we decide the meaning of the 

> 
> > On Wed, 2005-01-12 at 13:06, Greg KH wrote:
> >  >
> > > > If we are doing things incorrectly, I am not argueing that our 
> > usage
> >  > > has to the way it sits. We could create a new generic 
> > serial_device and
> > > > flash_device structures and subsystems for these, but that requires
> > > > rewriting drivers and board ports; however, we need enough time
> >  > > to work with appropriate subsystem maintainers to do so. My 
> > suggestion
> >  > > is to add a new firmware_data field for use by ACPI ATM while we
> >  > > clean things up in ARM world if so required.  Since ACPI is 
> > non-existent
> > > > on ARM systems, another option is that we keep using the renamed 
> > data
> >  > > structure as we have been doing. /me votes for this option
> >  >
> > > I like the "just add a firmware_data" field option too.  It doesn't
> > > break any existing code, and the term "firmware" tells driver 
> > authors to
> >  > back away from it and not touch it (and we need to add the proper
> > > documentation saying this.)
> >  If nobody insists on the intent of platform_data, I'll be glad to add 
> > a
> >  new field. It makes things more easy.
> >
> > Thanks,
> >  Shaohua


