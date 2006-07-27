Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWG0XcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWG0XcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWG0XcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:32:09 -0400
Received: from styx.suse.cz ([82.119.242.94]:25809 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750707AbWG0XcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:32:08 -0400
Date: Fri, 28 Jul 2006 01:31:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: "Brown, Len" <len.brown@intel.com>,
       Shem Multinymous <multinymous@gmail.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060727233154.GB4907@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <20060727221632.GE3797@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727221632.GE3797@elf.ucw.cz>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 12:16:32AM +0200, Pavel Machek wrote:


> /dev/XXX
> + battery layer will need to be invented
> - that layer will need maintainer
> + maintainer ensures this is not a mess, allocates numbers

  and figures out which features are identical, which not, etc. This
  	will actually be a lot easier than with keyboards: The number of
	different battery drivers/types is rather limited fortunately.

  note: It's absolutely necessary to limit the API to a well usable
	SUBSET of a superset of the features of all drivers/devices,
	even sacrificing obscure features to keep the API sane. One
	example would be the HID Power spec, which simply can't be
	supported to full extent by any sane API.

> - does not quite suit zaurus-style batteries, that can _only_ be
> 	polled. Can be worked-around by polling from kernel (and we
> 	are often doing that, anyway)

  + and the kernel can change the polling frequency based on power
	saving state changes

> + userspace backdoor interface will need to be invented, /dev/uinput style
> - hard to handle obscure features
> 	(do_not_charge_battery_for_X_minutes), and we'll probably want
> 	to unify batteries a bit, probably loosing precision.

-- 
Vojtech Pavlik
Director SuSE Labs
