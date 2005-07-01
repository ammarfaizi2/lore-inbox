Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVGAFQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVGAFQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 01:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263220AbVGAFQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 01:16:06 -0400
Received: from [206.246.247.150] ([206.246.247.150]:46528 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261290AbVGAFQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 01:16:02 -0400
Date: Fri, 1 Jul 2005 01:15:55 -0400
From: Ben Collins <bcollins@debian.org>
To: Andrew Morton <akpm@osdl.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: Problems with Firewire and -mm kernels
Message-ID: <20050701051554.GB12915@phunnypharm.org>
References: <20050628161500.GA25788@phunnypharm.org> <20050701010157.GA7877@ime.usp.br> <20050701011226.GB2067@phunnypharm.org> <20050701024432.GA18150@ime.usp.br> <20050701031801.GA12915@phunnypharm.org> <20050701043038.GA4537@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701043038.GA4537@ime.usp.br>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 01:30:39AM -0300, Rog?rio Brito wrote:
> On Jun 30 2005, Ben Collins wrote:
> > Try reverting just the sbp2.[ch] changes from the 2.6.13-rc1 tree.
> 
> Ok, I did that and it worked fine, thanks! I'm trying to upload the
> resulting dmesg so that you can see yourself, but it seems that my
> University's site isn't working for some reason. :-(
> 
> Oh, I got one warning when I was compiling sbp2.c (it was something like an
> invalid initialization around line 27xx--yes, yes, I know that this doesn't
> help much, but I don't have the log of the compilation here).

Ok, so the TYPE_SDAD/TYPE_RBC changes did affect sbp2. I think the changes
look a little much for what it was trying to accomplish (moving code
around between functions and changing logic paths is a little much when no
one tests it).

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
SwissDisk  - http://www.swissdisk.com/
