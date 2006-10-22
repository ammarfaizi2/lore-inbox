Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422910AbWJVBx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422910AbWJVBx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 21:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422911AbWJVBxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 21:53:25 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:62185 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422910AbWJVBxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 21:53:24 -0400
Date: Sun, 22 Oct 2006 03:53:19 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: Andi Kleen <ak@suse.de>, patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/2] x86_64: increase PHB1 split transaction timeout
Message-ID: <20061022015319.GH5211@rhun.haifa.ibm.com>
References: <200610221250.493223000@suse.de> <20061021225053.A213913B62@wotan.suse.de> <Pine.LNX.4.64N.0610211606430.9839@attu3.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0610211606430.9839@attu3.cs.washington.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 04:13:28PM -0700, David Rientjes wrote:

> > +static void __init calgary_increase_split_completion_timeout(void __iomem *bbar,
> > +	unsigned char busnum)
> > +{
> > +	u64 val64;
> > +	void __iomem *target;
> > +	unsigned long phb_shift = -1;
> 
> The initialization of this to -1 is unclear to me since we fall through to 
> BUG_ON() if busno_to_phbid() returns anything under than 0-3.  A shift 
> value of MAX_ULONG is never appropriate.

Without the initialization gcc warns about 'phb_shift' potentially
being used unitialized. I used '-1' exactly because it is never
appropriate.

Cheers,
Muli
