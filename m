Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317409AbSGDNdH>; Thu, 4 Jul 2002 09:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317410AbSGDNdG>; Thu, 4 Jul 2002 09:33:06 -0400
Received: from mta01ps.bigpond.com ([144.135.25.133]:52984 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317409AbSGDNdE>; Thu, 4 Jul 2002 09:33:04 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>,
       "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Multiple profiles
Date: Thu, 4 Jul 2002 23:28:24 +1000
User-Agent: KMail/1.4.5
References: <EE83E551E08D1D43AD52D50B9F511092E11411@ntserver2>
In-Reply-To: <EE83E551E08D1D43AD52D50B9F511092E11411@ntserver2>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207042328.24263.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2002 23:19, Gregory Giguashvili wrote:
> One might think of external devices (tapes, scaners, disks, etc.) constanly
> being moved from machine to machine. I understand I can twist /etc/init.d/*
> to support all the configurations. However, I don't see a reason why it
> cannot be the responsibility of Linux kernel to "see" different hardware
> configurations on boot.
We can do this, for some device types. Not just for boot, but for hotplug type 
devices as well. The kernel option is CONFIG_HOTPLUG, and it signals 
userspace to describe what went on.

It is not appropriate for the kernel to decide what goes on (eg, if you attach 
a USB scanner, whether you'd like to load the necessary kernel modules, start 
up KDE and kooka, start a scan and save to /tmp/pr0n; or just ignore it for 
now because the scanner is noisy, and you'll start it running overnight from 
a cron job). So we make such policy decisions in userspace. This is normally 
some shell script run as /sbin/hotplug (although you can change the script 
name using a /proc interface). Sample scripts can be downloaded from 
http://linux-hotplug.sf.net, which has lots more documentation on this.

Does this address your concern?

Brad

-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
