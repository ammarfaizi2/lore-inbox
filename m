Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422753AbWAMR4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422753AbWAMR4m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 12:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422756AbWAMR4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 12:56:41 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:23434 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1422753AbWAMR4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 12:56:40 -0500
Date: Fri, 13 Jan 2006 10:06:21 -0800
From: thockin@hockin.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual core Athlons and unsynced TSCs
Message-ID: <20060113180620.GA14382@hockin.org>
References: <1137104260.2370.85.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137104260.2370.85.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 05:17:39PM -0500, Lee Revell wrote:
> It's been known for quite some time that the TSCs are not synced between
> cores on Athlon X2 machines and this screws up the kernel's timekeeping,
> as it still uses the TSC as the default time source on these machines.
> 
> This problem still seems to be present in the latest kernels.  What is
> the plan to fix it?  Is the fix simply to make the kernel use the ACPI
> PM timer by default on Athlon X2?

If your BIOS has an ACPI "HPET" table, then the kernel can use the HPET
timer instead.  It doesn't solve the problem for apps or other kernel bits
that use rdtsc directly, but there are other fixes for that floating
around which will hopefully get consideration when they're mature.
