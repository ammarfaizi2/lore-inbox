Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVLDUHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVLDUHg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 15:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVLDUHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 15:07:36 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60592 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932329AbVLDUHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 15:07:35 -0500
Subject: Re: [PATCH] CPU frequency display in /proc/cpuinfo
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       cpufreq <cpufreq@www.linux.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051204183239.GE14247@wotan.suse.de>
References: <20051202181927.GD9766@wotan.suse.de>
	 <20051202104320.A5234@unix-os.sc.intel.com>
	 <20051204164335.GB32492@isilmar.linta.de>
	 <20051204183239.GE14247@wotan.suse.de>
Content-Type: text/plain
Date: Sun, 04 Dec 2005 14:49:26 -0500
Message-Id: <1133725767.19768.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-04 at 19:32 +0100, Andi Kleen wrote:
> On Sun, Dec 04, 2005 at 05:43:35PM +0100, Dominik Brodowski wrote:
> > On Fri, Dec 02, 2005 at 10:43:20AM -0800, Venkatesh Pallipadi wrote:
> > > The patch below changes this to:
> > > Show the last known frequency of the particular CPU, when cpufreq is present. If
> > > cpu doesnot support changing of frequency through cpufreq, then boot frequency 
> > > will be shown. The patch affects i386, x86_64 and ia64 architectures.
> > 
> > Looks good to me -- however, might this affect userspace cpufreq tools? I'd
> 
> They normally use /sys anyways.

Wrong, lots of userspace programs that need to know the CPU speed get it
from /proc/cpuinfo.  It would be nice if there were a better API.

As long as you don't change the file format it should be OK.

Lee

