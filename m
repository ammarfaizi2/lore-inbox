Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbVI3HO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVI3HO0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 03:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbVI3HOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 03:14:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:20612 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932572AbVI3HOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 03:14:25 -0400
Subject: Re: iMac G5: experimental thermal & cpufreq support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc64-dev@ozlabs.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
In-Reply-To: <1127983229.6102.60.camel@gaston>
References: <1127978432.6102.53.camel@gaston>
	 <1127983229.6102.60.camel@gaston>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 17:12:12 +1000
Message-Id: <1128064333.31197.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 18:40 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2005-09-29 at 17:20 +1000, Benjamin Herrenschmidt wrote:
> 
> > http://gate.crashing.org/~benh/ppc64-smu-thermal-control.diff
> 
> You may want to re-download this one if you got it already, I just fixed
> a bug in the calculations of the CPU control loop. It's now getting
> results much more consistant with OS X. I still have to add some
> overtemp handling and I'll remove the debug stuff and work on supporting
> the PowerMac9,1 desktop model.

Ok, I've updated it. News are:

 - It now requires cpufreq support (it won't start if the cpufreq clamp
sensor isn't loaded). I also changed the Kconfig stuff a bit, you'll
need to enable 2 options now

 - It has some totally untested support for PowerMac9,1

 - It has overtemp support (will slow CPU down and blow fans full speed
if the machine goes overtemp)

 - It has some basic sysfs interface to read values
in /sys/devices/platform/windfarm.0

 - DEBUG is disabled by default

Enjoy !

Ben.


