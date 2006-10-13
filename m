Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWJMD7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWJMD7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 23:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbWJMD7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 23:59:35 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:43276 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751258AbWJMD7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 23:59:34 -0400
Date: Thu, 12 Oct 2006 21:57:43 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Strange entries in /proc/acpi/thermal_zone for Thinkpad X60
In-reply-to: <fa.P/oAhFV0AVrh8PKSKzP+xVGih2s@ifi.uio.no>
To: Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: "Brown, Len" <len.brown@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Message-id: <452F0EB7.2060508@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
References: <fa.P/oAhFV0AVrh8PKSKzP+xVGih2s@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> I have a Thinkpad X60 with an Intel Core Duo T2400.  In 
> /proc/acpi/thermal_zone, I'm getting two subdirectories, each with their 
> own set of files:
> 

So your machine has two thermal zones..

> The interesting thing is that the two sets of files are not consistent - 
> sometimes they don't even show the same temperature.

I would expect they wouldn't, otherwise there would be no reason for the 
BIOS people to set up two thermal zones..

> 
> The reason I'm interested in this is that I think it's behind some of my 
> cpufreq problems.  Sometimes the kernel decides that I just can't raise 
> the max frequency above 1GHz, because its been thermally limited (I've 
> put printks in to confirm that its the ACPI thermal limit on the policy 
> notifier chain which is limiting the max speed).  It seems to me that 
> having a thermal zone for each core is a BIOS bug, since they're really 
> the same chip, but the THM1 entries should be ignored.  I don't believe 

How do you know they are one for each core? ACPI thermal zones can be 
anywhere in the machine that needs OS-controlled cooling. Could be the 
CPU heatsink, voltage regulator, or someplace else.

> the CPU has ever approached either 97 C, let alone 127; while I put it 
> under a fair amount of load, it is sitting on a desktop with no airflow 
> obstructions, so if it really is overheating it suggests a serious 
> design problem with the hardware.
> 
> But I'm just speculating; I'm not really sure what all this means.  Any 
> clues?

I think we need more information to decide what is going on here.. what 
temperatures are registering in the thermal zones when the CPU clock is 
being limited?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

