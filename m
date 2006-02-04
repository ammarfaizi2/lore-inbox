Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946308AbWBDEmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946308AbWBDEmn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 23:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946307AbWBDEmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 23:42:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:46283 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946303AbWBDEmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 23:42:42 -0500
Date: Fri, 3 Feb 2006 22:42:34 -0600
From: Mark Maule <maule@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: pj@sgi.com, linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       tony.luck@intel.com, gregkh@suse.de
Subject: Re: Altix SN2 2.6.16-rc1-mm5 build breakage (was:  msi support)
Message-ID: <20060204044234.GA31134@sgi.com>
References: <20060119194647.12213.44658.14543@lnx-maule.americas.sgi.com> <20060119194702.12213.16524.93275@lnx-maule.americas.sgi.com> <20060203201441.194be500.pj@sgi.com> <20060203202531.27d685fa.akpm@osdl.org> <20060203202742.1e514fcc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203202742.1e514fcc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 08:27:42PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > So it
> >  looks like you've found a fix for a patch which isn't actually in -mm any
> >  more.  I sent that fix to Greg the other day.
> 
> Actually, gregkh-pci-altix-msi-support-git-ia64-fix.patch fix`es
> git-ia64.patch when gregkh-pci-altix-msi-support.patch is also applied, so
> it's not presently useful to either Greg or Tony.  I'll take care of it,
> somehow..
> 

I think what happened here is that I submitted a patchset for msi
abstractions (and others posted a couple of subsequent bugfix incrementals),
but these were not taken into the 2.6.16 base 'cause of their invasiveness.
These patches touched the tioce_provider.c file.

Then I submitted another patch which touched the tioce_provider.c file, and
it looks like I probably based this file on the previous msi versions which
were being held back, so in order for everything to build, you need all of
the msi patches applied first.

What's the preferred way to handle this ... fix the current ia64 build and
then resubmit the msi patches relative to that base?

Mark
