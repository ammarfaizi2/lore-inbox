Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVIFXMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVIFXMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750987AbVIFXMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:12:55 -0400
Received: from fmr22.intel.com ([143.183.121.14]:13238 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750960AbVIFXMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:12:55 -0400
Date: Tue, 6 Sep 2005 16:12:15 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, ashok.raj@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 13/14] x86_64: Use common functions in cluster and physflat mode
Message-ID: <20050906161215.B19592@unix-os.sc.intel.com>
References: <200509032135.j83LZ8gX020554@shell0.pdx.osdl.net> <20050905231628.GA16476@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050905231628.GA16476@muc.de>; from ak@muc.de on Tue, Sep 06, 2005 at 01:16:28AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 01:16:28AM +0200, Andi Kleen wrote:
> On Sat, Sep 03, 2005 at 02:33:30PM -0700, akpm@osdl.org wrote:
> > 
> > From: Ashok Raj <ashok.raj@intel.com>
> > 
> > Newly introduced physflat_* shares way too much with cluster with only a very
> > differences.  So we introduce some common functions in that can be reused in
> > both cases.
> > 
> > In addition the following are also fixed.
> > - Use of non-existent CONFIG_CPU_HOTPLUG option renamed to actual one in use.
> > - Removed comment that ACPI would provide a way to select this dynamically
> >   since ACPI_CONFIG_HOTPLUG_CPU already exists that indicates platform support
> >   for hotplug via ACPI. In addition CONFIG_HOTPLUG_CPU only indicates logical 
> >   offline/online which is even used by Suspend/Resume folks where the same 
> >   support (for no-broadcast) is required.
> 
> 
> (hmm did I reply to that? I think I did but my mailer seems to have
> lost the r flag. My apologies if it's a duplicate) 
> 
> I didn't like that one because it makes the code less readable than
> before imho. I did a separate patch for the CPU_HOTPLUG typo.

The code is less readable? Now iam confused. Attached the link to patch
below to refresh your memory.

http://marc.theaimsgroup.com/?l=linux-kernel&m=112293577309653&w=2

diffstat would show we have fewer lines ~40 less lines of code. physflat
basicaly copied/cloned some useful code in cluster and some from flat mode
genapic code. 

I would have consolidated the code in the first place when you put the physflat
mode. Again this was just my habit, cant step over code bloat and duplication.

Which part of the code is unreadable to you? If you are happy with just renamed
functions with copied body of the code which is what physflat did, thats fine.

I was just puzzeled at the convoluted and less readable part of the code. If 
there is something you like to point out, i would be happy to fix it.. or you 
can if you prefer it that way.


-- 
Cheers,
Ashok Raj
- Open Source Technology Center
