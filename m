Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVAHAGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVAHAGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVAHACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:02:13 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:43399 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261719AbVAGX7y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:59:54 -0500
Date: Sat, 8 Jan 2005 00:58:44 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
Message-ID: <20050107235844.GA8351@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Greg KH <greg@kroah.com>,
	Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
	arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
	wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
	greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com> <41DEC0BF.4010708@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DEC0BF.4010708@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 09:02:55AM -0800, Randy.Dunlap wrote:
> Add 2.4.x cpufreq /proc and sysctl interface removal
> to the feature-removal-schedule.

As it is already removed in Davej's cpufreq bitkeeper tree, I don't know if
it's still desired or not, but:

> +What:	/proc/sys/cpu and the sysctl interface to cpufreq (2.4.x interfaces)
> +When:	January 2005
> +Files:	drivers/cpufreq/: cpufreq_userspace.c, proc_intf.c
> +	function calls throughout the kernel tree
> +Why:	Deprecated, has been replaced/superseded by (what?)....
> +Who:	Dominik Brodowski <linux@brodo.de>

What: /proc/sys/cpu/*, sysctl and /proc/cpufreq interfaces to cpufreq (2.4.x interfaces)
When: January 2005
Files: drivers/cpufreq/: cpufreq_userspace.c, proc_intf.c
Why: /proc/sys/cpu/* has been deprecated since inclusion of cpufreq into the
     main kernel tree. It bloats /proc/ unnecessarily and doesn't work
     well with the "governor"-based design of cpufreq. 
     /proc/cpufreq/* has also been deprecated for a long time and was only
     meant for usage during 2.5. until the new sysfs-based interface became
     ready. It has an inconsistent interface which doesn't work well with
     userspace setting the frequency. The output from /proc/cpufreq/* can
     be emulated using "cpufreq-info --proc" (cpufrequtils).
     Both interfaces are superseded by the cpufreq interface in
     /sys/devices/system/cpu/cpu%n/cpufreq/.
Who: Dominik Brodowski <linux@brodo.de>
