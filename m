Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268954AbTGORga (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbTGORg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:36:29 -0400
Received: from www.strato-webmail.de ([192.166.196.79]:32420 "EHLO
	voodoo.strato-webmail.de") by vger.kernel.org with ESMTP
	id S268954AbTGORfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:35:21 -0400
From: lkml@brodo.de
To: linux-kernel@vger.kernel.org, ian.soboroff@nist.gov, davej@suse.de
Subject: RE: 2.6.0-test1 - cpu_freg sysfs nodes?
X-Mailer: STRATO-Webmail.de, powered by PHlyMail LE, http://phlymail.com
X-Sender-IP: 80.138.180.195
Message-Id: <20030715175010.CE2428275@voodoo.strato-webmail.de>
Date: Tue, 15 Jul 2003 19:50:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mattia Dongili <dongili@supereva.it> writes:
> 
> > find /sys -iname 'cpu*'
> >
> > /sys/firmware/acpi/namespace/ACPI/CPU0
> > /sys/devices/system/cpu
> > /sys/devices/system/cpu/cpu0
> > /sys/devices/system/cpu/cpu0/cpufreq
> > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
> > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
> 
> If this is the right place to look, the Documentation/cpu-freq needs
> some updating.
Patch for this is already in davej's queue.

> But this still isn't it...
> 
> # find /sys -iname 'cpu*'
> /sys/devices/system/cpu
> /sys/devices/system/cpu/cpu0
> /sys/cdev/major/cpu!cpuid
> /sys/cdev/major/cpu!msr

There is a problem with the proper detection of longrun CPUs, see this
patch please [davej: can you appply this to your tree, too, please?]

http://marc.theaimsgroup.com/?l=linux-kernel&m=105797182628099&w=2

    Dominik
