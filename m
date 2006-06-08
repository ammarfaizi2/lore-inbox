Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWFHULk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWFHULk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 16:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWFHULk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 16:11:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15890 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964969AbWFHULj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 16:11:39 -0400
Date: Thu, 8 Jun 2006 12:45:06 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Don Zickus <dzickus@redhat.com>, ak@suse.de, shaohua.li@intel.com,
       miles.lane@gmail.com, jeremy@goop.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Message-ID: <20060608124506.GB4006@ucw.cz>
References: <4480C102.3060400@goop.org> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <20060606141755.GN2839@redhat.com> <200606061618.15415.ak@suse.de> <20060606214553.GB11696@redhat.com> <20060606151507.613edaad.akpm@osdl.org> <20060606230504.GC11696@redhat.com> <20060606162201.f0f9f308.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060606162201.f0f9f308.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Is the typical approach to just hack in an extra parameter to the
> > start/stop functions of the nmi_watchdog letting the function know it is
> > coming through the suspend/resume path? 
> > 
> > Any tips, code, other docs would be helpful.
> > 
> 
> OK...  My understanding of how it works is that the cpu hotplug handlers
> are called early in the suspend process to take the CPUs down.  Once all
> the APs are shut down, CPU0 will then proceed to handle the devices.

Yep.

> All the above applies to suspend-to-disk.  I don't know if suspend-to-RAM
> shuts down the APs.

It applies to suspend-to-ram, too.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
