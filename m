Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbVALFIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVALFIg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263029AbVALFIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:08:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:26758 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263028AbVALFGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:06:22 -0500
Date: Tue, 11 Jan 2005 21:06:17 -0800
From: Greg KH <greg@kroah.com>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Li Shaohua <shaohua.li@intel.com>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, rmk@arm.linux.org.uk
Subject: Re: [PATCH]change 'struct device' -> platform_data to firmware_data
Message-ID: <20050112050617.GB976@kroah.com>
References: <1105498626.26324.14.camel@sli10-desk.sh.intel.com> <20050112035446.GA11251@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112035446.GA11251@plexity.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 07:54:46PM -0800, Deepak Saxena wrote:
> 
> So the question I have is whether we are using the field as intended
> or we have overloaded it with our own purposes?

You have used it for your own purposes :)

But I would argue that you used it in a way that works, and solves a
real need.  As the intent of this field was never really properly
conveyed, and since you were here first, hey, your implementation gets
to stay!

> If we are doing things incorrectly, I am not argueing that our usage
> has to the way it sits. We could create a new generic serial_device and 
> flash_device structures and subsystems for these, but that requires 
> rewriting drivers and board ports; however, we need enough time
> to work with appropriate subsystem maintainers to do so. My suggestion
> is to add a new firmware_data field for use by ACPI ATM while we
> clean things up in ARM world if so required.  Since ACPI is non-existent 
> on ARM systems, another option is that we keep using the renamed data
> structure as we have been doing. /me votes for this option

I like the "just add a firmware_data" field option too.  It doesn't
break any existing code, and the term "firmware" tells driver authors to
back away from it and not touch it (and we need to add the proper
documentation saying this.)

thanks,

greg k-h
