Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263029AbVALFWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263029AbVALFWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbVALFVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:21:34 -0500
Received: from fmr17.intel.com ([134.134.136.16]:63945 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261245AbVALFQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:16:48 -0500
Subject: Re: [PATCH]change 'struct device' -> platform_data to firmware_data
From: Li Shaohua <shaohua.li@intel.com>
To: Greg KH <greg@kroah.com>
Cc: Deepak Saxena <dsaxena@plexity.net>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, rmk@arm.linux.org.uk
In-Reply-To: <20050112050617.GB976@kroah.com>
References: <1105498626.26324.14.camel@sli10-desk.sh.intel.com>
	 <20050112035446.GA11251@plexity.net>  <20050112050617.GB976@kroah.com>
Content-Type: text/plain
Message-Id: <1105506942.3081.6.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 12 Jan 2005 13:15:42 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-12 at 13:06, Greg KH wrote:
> 
> > If we are doing things incorrectly, I am not argueing that our usage
> > has to the way it sits. We could create a new generic serial_device and 
> > flash_device structures and subsystems for these, but that requires 
> > rewriting drivers and board ports; however, we need enough time
> > to work with appropriate subsystem maintainers to do so. My suggestion
> > is to add a new firmware_data field for use by ACPI ATM while we
> > clean things up in ARM world if so required.  Since ACPI is non-existent 
> > on ARM systems, another option is that we keep using the renamed data
> > structure as we have been doing. /me votes for this option
> 
> I like the "just add a firmware_data" field option too.  It doesn't
> break any existing code, and the term "firmware" tells driver authors to
> back away from it and not touch it (and we need to add the proper
> documentation saying this.)
If nobody insists on the intent of platform_data, I'll be glad to add a
new field. It makes things more easy.

Thanks,
Shaohua

