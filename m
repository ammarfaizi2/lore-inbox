Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWFSU5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWFSU5U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 16:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWFSU5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 16:57:20 -0400
Received: from isilmar.linta.de ([213.239.214.66]:61893 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932318AbWFSU5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 16:57:19 -0400
Date: Mon, 19 Jun 2006 22:57:18 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Thomas Gleixner <tglx@timesys.com>, len.brown@intel.com
Cc: Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>
Subject: ACPI C-States algorithm updates for dyn-tick
Message-ID: <20060619205718.GA26332@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Thomas Gleixner <tglx@timesys.com>, len.brown@intel.com,
	Con Kolivas <kernel@kolivas.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	john stultz <johnstul@us.ibm.com>
References: <1150643426.27073.17.camel@localhost.localdomain> <200606191521.05508.kernel@kolivas.org> <20060619122606.GA19451@elte.hu> <200606200003.26008.kernel@kolivas.org> <1150747611.29299.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150747611.29299.77.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
On Mon, Jun 19, 2006 at 10:06:51PM +0200, Thomas Gleixner wrote:
> On Tue, 2006-06-20 at 00:03 +1000, Con Kolivas wrote:
> > Dominik donated a lot of code to use the dynticks infrastructure to actually 
> > implement the power savings. Just skipping ticks seemed to make very little 
> > power difference unless we also used the knowledge from next timer interrupt 
> > to know how long we are going to be idle and choose C state transitions 
> > accordingly. Each patch is documented at length in the split out
> > 
> > C-States-1_bm_activity_improvements.patch
> > C-States-2_bm_activity_handling_improvement.patch
> > C-States-3_accounting_of_sleep_times.patch
> > C-States-4_dyn-ticks_tweaks.patch
> > 
> > http://ck.kolivas.org/patches/dyn-ticks/split-out/
> 
> Thanks for pointing that out. We'll look into those tomorrow.

1 to 3 were already submitted to Len, as they're useful already right now.
(Len: do you want me to re-submit, as I can't find them in a git tree right
now?) The fourth one is the only dyn-tick-specific one, and probably needs
some more tweaking, testing and benchmarking.

	Dominik
