Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWALCad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWALCad (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWALCad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:30:33 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:50571 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932676AbWALCad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:30:33 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
To: xen-devel@lists.xensource.com
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
Date: Thu, 12 Jan 2006 02:17:52 +0000
User-Agent: KMail/1.9.1
Cc: "Mike D. Day" <ncmike@us.ibm.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <43C53DA0.60704@us.ibm.com> <20060112005710.GA2936@kroah.com> <43C5B59C.8050908@us.ibm.com>
In-Reply-To: <43C5B59C.8050908@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601120217.53610.mark.williamson@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guys,

I think the waters are getting a bit muddied here regarding Xen (the 
hypervisor, a separate project which boots natively on the hardware, not a 
module or patch to Linux) vs. the Xen Patch to Linux (allowing i386 Linux to 
run on top of that hypervisor's APIs).

> >>The module version? Xen is not a module nor a driver, so that interface
> >>doesn't quite serve the purpose.
> >
> > Then it doesn't need a separate version, as it is the same as the main
> > kernel version, right?  Just because your code is out-of-the-tree right

> > Huh?  You can't just throw a "MODULE_VERSION()", and a module_init()
> > somewhere into the xen code to get this to happen?  Then all of your
> > configurable paramaters show up automagically.

To put it another way, when Mike referred to "Xen", he meant the hypervisor 
itself, not part of the patch to Linux.  The version attribute under /sys/xen 
is therefore describing the version of the "virtual hardware" that's provided 
by the Xen<->guest OS interface, not for describing / configuring the 
Xen-aware portion of Linux itself.

(side note: Xen's quite like a CPU arch / extended hardware platform in some 
ways, although it's kinda orthogonal to the particular hardware platform in 
use.  Mike - had you looked at how CPU entries are registered 
in /sys/devices/system, for instance?  anything there you could leverage?)

Cheers,
Mark


-- 
Dave: Just a question. What use is a unicyle with no seat?  And no pedals!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
