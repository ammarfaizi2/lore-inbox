Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWHKVyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWHKVyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWHKVyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:54:00 -0400
Received: from rtr.ca ([64.26.128.89]:25517 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932295AbWHKVx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:53:59 -0400
Message-ID: <44DCFC73.7020103@rtr.ca>
Date: Fri, 11 Aug 2006 17:53:55 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: cpufreq stops working after a while
References: <EB12A50964762B4D8111D55B764A84546F8F82@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A84546F8F82@scsmsx413.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pallipadi, Venkatesh wrote:
>> Mark Lord wrote:
>> Yup, thermal.
>> Trips shortly after I see 66C in 
>> /proc/acpi/thermal_zone/THM/temperature
>>
>> If I stop number crunching for a bit, the temperature drops down to the
>> low 50's, and the max freq then gets set back to 1100.
>>
>> Mmmm.. is there a way to control the high/low thermostat values there?
..
> What is the "cooling mode" you have in
> /proc/acpi/thermal_zone/THM/cooling_mode.
> Output of all files in that directory will help.

/proc/acpi/thermal_zone/THM/cooling_mode:
	<setting not supported>
	cooling mode:   critical

/proc/acpi/thermal_zone/THM/polling_frequency:
	<polling disabled>

/proc/acpi/thermal_zone/THM/state:
	state:                   ok

/proc/acpi/thermal_zone/THM/temperature:
	temperature:             49 C

/proc/acpi/thermal_zone/THM/trip_points:
	critical (S5):           95 C

==========

This is a passively cooled notebook, so there's no fan
to control.  They probably self-limit the CPU speed when
the temperature gets high to prevent meltdown of the drive.

But I would like to raise the lower limit if possible,
allowing the speed to bump back up at, say 58C rather
than waiting for 52C as it currently does.

??

