Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266022AbUGETAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUGETAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 15:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUGETAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 15:00:37 -0400
Received: from fmr02.intel.com ([192.55.52.25]:58343 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S266022AbUGETAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 15:00:24 -0400
Subject: Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
From: Len Brown <len.brown@intel.com>
To: Sergio Vergata <vergata@stud.fbi.fh-darmstadt.de>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1089054013.15671.48.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Jul 2004 15:00:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 18:32, Sergio Vergata wrote:

> I have an IBM t40P. 
> Starting testing since i got my Laptop, Now starting with 2.6.7 and
> -mm1 i Switched from APM to ACPI  and use SwSusp.
>
> Now i trying to get the system working reliable with ACPI, suspending
> to RAM will not work as ist should it switch of Display Fan HDD this
> ist what i see 
> and hear, but it will not suspend DVDRom an for sure it leave the CPU 
> powered. I see that cpu i on because the system heats itself up. The
> time for 
> the suspended system is round about 10 hours after that the system
> powers of 
> and the battery is empty.

This does sound broken.  My centrino laptop draws well under 1W
when suspended to RAM, so on my 72Wh battery it should last
at least the better part of a week.

It would be interesting to know how long windows can STR
on your laptop.

> Problem number 2 is the problem that of suspending to ram will not
> reawake the interrupts of nvram and the acpi interrupts IRQ 9. 

Perhaps you can test the latest -mm tree plus
the patches from comment #21 adn #28 here:
http://bugzilla.kernel.org/show_bug.cgi?id=2643

thanks,
-Len


