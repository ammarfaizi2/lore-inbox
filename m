Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbTDDUkN (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbTDDUkM (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:40:12 -0500
Received: from compaq.com ([161.114.1.205]:51977 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S261242AbTDDUkC (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 15:40:02 -0500
Date: Fri, 4 Apr 2003 14:57:40 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: How to speed up building of modules?
Message-ID: <20030404085740.GA10052@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm wondering if you guys know any tricks to speed up building
of linux kernel modules.

First, some background.

We have to put out binary HBA driver modules for a variety
of linux distributions for things like driver diskettes, to allow
new drivers to be used during initial install.  (I'm thinking
of the cciss, cpqarray and cpqfc drivers.)

With all the distributions, and differnent
offerings of distributions, and errata kernels... today, I count
almost 40 distinct kernels we're trying to support, not counting the
mainline development on kernel.org, and not counting multiple
config file variations for each of those 40 or so kernels.

The main catch seems to be the symbol checksums.  In order for those
to match (and I'm not too interested in subverting those), the 
config files used during the compile need to be very similar.  That 
means building lots and lots of modules.  (Think about all the 
modules which are enabled in redhat's typical default config files.)
This takes time.  Mulitply 3 drivers * ~40 kernels * several config
files, and pretty soon... well, pretty soon you don't remember
what "preety soon" means.

It would be VERY nice if I could find a way to build only the modules
I care about  and not all the rest, which add hours and hours.
It seems that some things in the config file can be turned off without
harm, but it's not clear how I can know whether it's safe to turn a module
off  Also, sometimes I need to make changes to the Config.in files, 
add options, etc.  Ccache hasn't helped.  (I think because the different 
config files use different compiler flags, and otherwise the kernels 
just aren't the same.)

Any ideas?

Thanks,

-- steve

