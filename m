Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422688AbWASXqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422688AbWASXqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 18:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422634AbWASXqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 18:46:13 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:49693 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1422686AbWASXqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 18:46:11 -0500
X-IronPort-AV: i="4.01,202,1136181600"; 
   d="scan'208"; a="30325048:sNHT17161068"
Date: Thu, 19 Jan 2006 17:46:12 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>, jamagallon@able.es,
       linux-kernel@vger.kernel.org
Subject: Re: 3c59x went nuts between .15-mm3 and .15-mm4
Message-ID: <20060119234612.GA16789@lists.us.dell.com>
References: <20060119225345.18a570ae@werewolf.auna.net> <20060119223114.GN16047@bayes.mathematik.tu-chemnitz.de> <20060119152757.6d7f3924.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119152757.6d7f3924.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 03:27:57PM -0800, Andrew Morton wrote:
> Steffen Klassert <klassert@mathematik.tu-chemnitz.de> wrote:
> >
> > The driver version did not increase since more than three years.
> > But perhaps it is a good idea to maintain the driver version. 
> 
> Just nuke it.  Per-driver versioning is pretty meaningless and we should
> and do identify driver versions by the version of the top-level kernel
> which contains them.

With all due respect, per-driver versioning in mainline may be
meaningless (and as you note, modinfo already carries the kernel
version in it), but as soon as it hits a vendor kernel, it means very
much, and is the primary method of denoting to a larger (and mostly
non-driver-developer) audience what hardware is supported, and what
critical (to the vendor) bugs have been addressed.

And some tools, such as DKMS, make explicit use of the MODULE_VERSION
tag to automate updating individual drivers without necessarily changing out the
whole vendor kernel.  Once the vendor kernel "catches up" with the
equivalent driver, DKMS won't replace it any more.  All of the drivers
critical to Dell are separately versioned exactly for this reason, and
those tags are in the code submitted to mainline.  (3c59x isn't in
that category I admit).

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
