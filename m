Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265033AbTIJQKN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbTIJQKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:10:13 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:1158 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S265033AbTIJQKF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:10:05 -0400
Date: Wed, 10 Sep 2003 18:10:01 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: Claas Langbehn <claas@rootdir.de>
Cc: Patrick Mochel <mochel@osdl.org>, <linux-kernel@vger.kernel.org>,
       Andrew de Quincey <adq@lidskialf.net>,
       <acpi-devel@lists.sourceforge.net>
Subject: Re: [2.6.0-test5-mm1] Suspend to RAM problems
In-Reply-To: <20030910154551.GA1507@rootdir.de>
Message-ID: <Pine.LNX.4.44.0309101806480.2528-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Claas Langbehn wrote:

> Patrick Mochel wrote:

> > > 2) ACPI
> > > Thanks to Andrew de Quincey I can boot with ACPI without
> > > problems and I can read out my temp and so on, but when I do
> > >    echo -n "mem" >/sys/power/state 
> > > the machine goes into sleep (STR) but crashes after waking up again.
> > 
> > What exactly does it do on wakeup? 

Mine crashes before suspending. It says something like:
Stoppings tasks
===========================================================
critical region / count pages [XXXXXXXXXXXX]

> When the system sleeps, it the power LED blinks. I call it wake-up
> when the system starts again. I press a key or the power button. Then
> the system beeps once and it comes back...
> 
> > Would you please try the patch at: 
> > http://developer.osdl.org/~mochel/patches/test5-pm1/test5-pm2.diff.bz2
> 
> i will try it and report about my experiences later.

I'll give it a try too.

> > >    echo -n "S3" > /proc/acpi/sleep 
> 
> > That should be:
> > 	echo "3" > /proc/acpi/sleep

$ ls /proc/acpi
ac_adapter  battery  dsdt                 event  fan   power_resource  thermal_zone
alarm       button   embedded_controller  fadt   info  processor

> > But, please use the sysfs interface. 

It hangs the computer.

Pau

