Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263405AbVBDRj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263405AbVBDRj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 12:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbVBDRZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 12:25:12 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:24045 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S266294AbVBDRXD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 12:23:03 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: i386 HPET code
Date: Fri, 4 Feb 2005 17:22:46 +0000
User-Agent: KMail/1.7.2
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       john stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       keith maanthey <kmannth@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
References: <88056F38E9E48644A0F562A38C64FB6003EA715C@scsmsx403.amr.corp.intel.com> <1107459056.2040.243.camel@cog.beaverton.ibm.com> <20050203120233.A23267@unix-os.sc.intel.com>
In-Reply-To: <20050203120233.A23267@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502041722.46430.andrew@walrond.org>
X-Spam-Score: -2.8 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 February 2005 20:02, Venkatesh Pallipadi wrote:
> On Thu, Feb 03, 2005 at 11:30:56AM -0800, john stultz wrote:
> > On Thu, 2005-02-03 at 06:28 -0800, Pallipadi, Venkatesh wrote:
> > > Can you check whether only the following change makes the problem go
> > > away. If yes, then it looks like a hardware issue.
> > >
> > > > hpet_writel(hpet_tick, HPET_T0_CMP);
> > > >+ hpet_writel(hpet_tick, HPET_T0_CMP); /* AK: why twice? */
> >
> > Yep. Adding only the second write seems to make the box boot.
> >

Just to confirm that this also fixes the problem for two types of MSI dual 
opteron motherboards. (MSI K8D Master 2/3)

Andrew Walrond
