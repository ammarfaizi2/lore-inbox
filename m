Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVKOAah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVKOAah (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVKOAag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:30:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3047 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932168AbVKOAag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:30:36 -0500
Date: Mon, 14 Nov 2005 19:30:26 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Doug Thompson <norsk5@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] EDAC and the sysfs
Message-ID: <20051115003026.GA12266@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Doug Thompson <norsk5@yahoo.com>, linux-kernel@vger.kernel.org
References: <20051114221419.10324.qmail@web50101.mail.yahoo.com> <20051114223105.GA5868@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051114223105.GA5868@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2005 at 02:31:05PM -0800, Greg Kroah-Hartman wrote:
 > On Mon, Nov 14, 2005 at 02:14:19PM -0800, Doug Thompson wrote:
 > > 
 > > I am trying to design the sysfs interface tree for the
 > > new set of EDAC modules that are waiting for this
 > > interface, before being put into the kernel.  
 > > 
 > > Currently the original EDAC (bluesmoke) has its own
 > > /proc directory (/proc/mc) with files and a directory
 > > (0,1,2,...)for each memory controller on the system.
 > > This will be removed and the new information interface
 > > will be placed in the sysfs.
 > > 
 > > One proposal is to place the information in
 > > /sys/devices/system in the following directories:
 > 
 > Why not use /sys/firmware/ instead?

Probably the same reason we don't have the cpufreq (for eg)
stuff under /sys/firmware.  Because it's poking hardware,
not manipulating firmware.

/sys/devices/system makes a lot more sense, as thats
where the cpu level machine check stuff is (amongst other
similar things).

 > > I have failed to date to really find a policy or set
 > > of rules of use for the sysfs as to what goes where
 > > for such items as EDAC. After searching the web,
 > > articles and thinking about this for some time now, I
 > > am requesting comments on the sysfs model for where
 > > EDAC would fit best.
 > 
 > What exactly does EDAC do (and what does it stand for anyway?)

Reports hardware events read from chipset specific registers.
Similar to /sys/devices/system/machinecheck/, but from
chipset instead of CPU. (That's grossly simplified, but
hopefully gets the idea across).

		Dave

