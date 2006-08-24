Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWHXQPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWHXQPn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030344AbWHXQPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:15:43 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:38844 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030338AbWHXQPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:15:42 -0400
Date: Thu, 24 Aug 2006 17:15:14 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Pavel Machek <pavel@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
Message-ID: <20060824161514.GA19753@srcf.ucam.org>
References: <EB12A50964762B4D8111D55B764A84546F8EC3@scsmsx413.amr.corp.intel.com> <44DCE8BA.2070601@rtr.ca> <44DCEAF7.5020005@rtr.ca> <20060811210104.GL26930@redhat.com> <44DCF360.7050305@rtr.ca> <44DCF5C1.4040506@rtr.ca> <20060818151122.GA8275@ucw.cz> <44EDBB4C.6040203@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EDBB4C.6040203@rtr.ca>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 10:44:28AM -0400, Mark Lord wrote:

> By definition, "passive" cooling never needs enabling -- this just refers
> to things like heat sinks and air vents.

In ACPI terms, passive cooling is forced downthrottling of the CPU in 
order to reduce heat generation. This is normally done if the 
temperature is continuing to rise despite active cooling being enabled.

On some hardware you can set the values at which different types of 
cooling will be enabled in /proc/acpi/thermal_zone/*/trip_points. Echo a 
colon separated list of values in there to rewrite them. Some BIOSes 
will change the trip points in response to various events, which will 
then overwrite your values.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
