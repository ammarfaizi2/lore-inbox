Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932215AbVLDScr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVLDScr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 13:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVLDScr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 13:32:47 -0500
Received: from ns1.suse.de ([195.135.220.2]:58781 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932215AbVLDScr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 13:32:47 -0500
Date: Sun, 4 Dec 2005 19:32:39 +0100
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
Message-ID: <20051204183239.GE14247@wotan.suse.de>
References: <20051202181927.GD9766@wotan.suse.de> <20051202104320.A5234@unix-os.sc.intel.com> <20051204164335.GB32492@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051204164335.GB32492@isilmar.linta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2005 at 05:43:35PM +0100, Dominik Brodowski wrote:
> On Fri, Dec 02, 2005 at 10:43:20AM -0800, Venkatesh Pallipadi wrote:
> > The patch below changes this to:
> > Show the last known frequency of the particular CPU, when cpufreq is present. If
> > cpu doesnot support changing of frequency through cpufreq, then boot frequency 
> > will be shown. The patch affects i386, x86_64 and ia64 architectures.
> 
> Looks good to me -- however, might this affect userspace cpufreq tools? I'd

They normally use /sys anyways.

> vote for quite some time in -mm for this patch (i.e. only merge for 2.6.17)

Actually it just changes behaviour back to older kernels (~2.6.10 or earlier) 
which always behaved like this.  So it should be safe.

-Andi
