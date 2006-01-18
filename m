Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWARSLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWARSLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWARSLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:11:19 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:52069 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S964862AbWARSLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:11:18 -0500
X-IronPort-AV: i="3.99,381,1131343200"; 
   d="scan'208"; a="29431794:sNHT16935792"
Date: Wed, 18 Jan 2006 12:11:17 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-ia64@vger.kernel.org, ak@suse.de,
       openipmi-developer@lists.sourceforge.net, akpm@osdl.org,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Openipmi-developer] Re: [PATCH 2.6.15] ia64: use i386 dmi_scan.c
Message-ID: <20060118181116.GA5537@lists.us.dell.com>
References: <20060104221627.GA26064@lists.us.dell.com> <200601131724.42054.bjorn.helgaas@hp.com> <200601171717.03192.bjorn.helgaas@hp.com> <200601181029.46352.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601181029.46352.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 10:29:46AM -0700, Bjorn Helgaas wrote:
> Matt, what's your opinion on proceeding?  I know you want to get
> the DMI stuff in distros.  I'm looking at reworking ioremap to
> hide all this stuff, but that'll be a bigger change and may be
> harder to get into distro releases.
> 
> For upstream, the ioremap rework sounds like the way to go, but
> I don't know which the distros would prefer for updates.

Existing distros (RHEL3, RHEL4, SLES9, ..) don't have a huge problem
because my target user - the ipmi driver - does its own DMI scanning
on those distros still.  Ugly, but works.  So the only concern is
SLES10 and RHEL5, both of which are still rebasing to upstream best as
I can tell from their publicly posted kernels.  So if it can be done
"right" in 2.6.16-rc, let's do that.  If it will be intrusive, and
after 2.6.16 is out, than a minimally intrusive but working patch for
2.6.16-rc would be preferred.

Thanks!
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
