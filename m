Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVALGUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVALGUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 01:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVALGUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 01:20:17 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:48043 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S261209AbVALGUI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 01:20:08 -0500
In-Reply-To: <1105506942.3081.6.camel@sli10-desk.sh.intel.com>
References: <1105506942.3081.6.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <37B1A29C-6460-11D9-8591-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Greg KH" <greg@kroah.com>, "Deepak Saxena" <dsaxena@plexity.net>,
       "Andrew Morton" <akpm@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>,
       <rmk@arm.linux.org.uk>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH]change 'struct device' -> platform_data to firmware_data
Date: Wed, 12 Jan 2005 00:07:19 -0600
To: "Li Shaohua" <shaohua.li@intel.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Embedded PPC has followed in ARMs footsteps with the use of 
platform_data for board specific information to be passed to drivers.   
The plan is to grow its use in embedded PPC. It would seem introducing 
a new field for ACPI information would be the least painful solution.

Can some clarify what kind of information ACPI needs.  I'm asking 
because firmware_data does not seem any more clear to me.

Also, we should really probably be a bit more specific in 
Documentation/driver-model/device.txt once we decide the meaning of the 
fields is, possible giving an example.

- kumar

On Jan 11, 2005, at 11:15 PM, Li Shaohua wrote:

> On Wed, 2005-01-12 at 13:06, Greg KH wrote:
>  >
> > > If we are doing things incorrectly, I am not argueing that our 
> usage
>  > > has to the way it sits. We could create a new generic 
> serial_device and
> > > flash_device structures and subsystems for these, but that requires
> > > rewriting drivers and board ports; however, we need enough time
>  > > to work with appropriate subsystem maintainers to do so. My 
> suggestion
>  > > is to add a new firmware_data field for use by ACPI ATM while we
>  > > clean things up in ARM world if so required.  Since ACPI is 
> non-existent
> > > on ARM systems, another option is that we keep using the renamed 
> data
>  > > structure as we have been doing. /me votes for this option
>  >
> > I like the "just add a firmware_data" field option too.  It doesn't
> > break any existing code, and the term "firmware" tells driver 
> authors to
>  > back away from it and not touch it (and we need to add the proper
> > documentation saying this.)
>  If nobody insists on the intent of platform_data, I'll be glad to add 
> a
>  new field. It makes things more easy.
>
> Thanks,
>  Shaohua
>
> -
>  To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/

