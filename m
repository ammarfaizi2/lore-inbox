Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422750AbWAMR6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422750AbWAMR6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422754AbWAMR6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:58:40 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:45257 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422750AbWAMR6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:58:39 -0500
Subject: Re: Dual core Athlons and unsynced TSCs
From: Lee Revell <rlrevell@joe-job.com>
To: thockin@hockin.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060113180620.GA14382@hockin.org>
References: <1137104260.2370.85.camel@mindpipe>
	 <20060113180620.GA14382@hockin.org>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 12:58:36 -0500
Message-Id: <1137175117.15108.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 10:06 -0800, thockin@hockin.org wrote:
> On Thu, Jan 12, 2006 at 05:17:39PM -0500, Lee Revell wrote:
> > It's been known for quite some time that the TSCs are not synced between
> > cores on Athlon X2 machines and this screws up the kernel's timekeeping,
> > as it still uses the TSC as the default time source on these machines.
> > 
> > This problem still seems to be present in the latest kernels.  What is
> > the plan to fix it?  Is the fix simply to make the kernel use the ACPI
> > PM timer by default on Athlon X2?
> 
> If your BIOS has an ACPI "HPET" table, then the kernel can use the HPET
> timer instead.  It doesn't solve the problem for apps or other kernel bits
> that use rdtsc directly, but there are other fixes for that floating
> around which will hopefully get consideration when they're mature.
> 

The apps can be converted to use clock_gettime(), but that does not help
if the kernel can't keep reasonable time on these machines. 

But if we just use "clock=pmtmr" by default on these machines the TSC is
not a problem right?

Lee

