Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbTIJPqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbTIJPqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:46:19 -0400
Received: from luli.rootdir.de ([213.133.108.222]:22193 "HELO luli.rootdir.de")
	by vger.kernel.org with SMTP id S265093AbTIJPqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:46:00 -0400
Date: Wed, 10 Sep 2003 17:45:51 +0200
From: Claas Langbehn <claas@rootdir.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew de Quincey <adq@lidskialf.net>,
       acpi-devel@lists.sourceforge.net
Subject: Re: [2.6.0-test5-mm1] Suspend to RAM problems
Message-ID: <20030910154551.GA1507@rootdir.de>
References: <20030910103142.GA1053@rootdir.de> <Pine.LNX.4.33.0309100829470.1012-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309100829470.1012-100000@localhost.localdomain>
Reply-By: Sa Sep 13 17:38:04 CEST 2003
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.0-test5-mm1 i686
X-No-archive: yes
X-Uptime: 17:38:04 up  4:21,  5 users,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:

> > 1.) APM:   (ACPI follows...)
> > apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
> 
> It's likely that if your system supports ACPI, the APM implementation will 
> not work, especially if you boot with ACPI enabled. 

Sure. That was with an APM-only enabled kernel.


> > 2) ACPI
> > Thanks to Andrew de Quincey I can boot with ACPI without
> > problems and I can read out my temp and so on, but when I do
> >    echo -n "mem" >/sys/power/state 
> > the machine goes into sleep (STR) but crashes after waking up again.
> 
> What exactly does it do on wakeup? 

When the system sleeps, it the power LED blinks. I call it wake-up
when the system starts again. I press a key or the power button. Then
the system beeps once and it comes back...

> Would you please try the patch at: 
> http://developer.osdl.org/~mochel/patches/test5-pm1/test5-pm2.diff.bz2

i will try it and report about my experiences later.


> Also, please try removing all modules before suspending and reinserting 
> them after resuming. 
I did that. But I have a lot inside the kernel. I will try to modularise
more.

> Do you have any of the following enabled: 
> 
> SMP?
no

> Preempt?
no

> APIC?
yes:
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y


> >    echo -n "S3" > /proc/acpi/sleep 

> That should be:
> 	echo "3" > /proc/acpi/sleep
> 
> But, please use the sysfs interface. 

alright. but that has the same effects.




bye, claas
