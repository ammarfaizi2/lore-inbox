Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWDEN7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWDEN7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 09:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWDEN7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 09:59:30 -0400
Received: from mail.gmx.de ([213.165.64.20]:43179 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750709AbWDEN7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 09:59:30 -0400
X-Authenticated: #14349625
Subject: Re: p4-clockmod not working in 2.6.16
From: Mike Galbraith <efault@gmx.de>
To: Tim Phipps <tim@phipps-hutton.freeserve.co.uk>
Cc: linux-kernel@vger.kernel.org, Edgar Toernig <froese@gmx.de>,
       Dave Jones <davej@redhat.com>
In-Reply-To: <1144245205.7571.11.camel@homer>
References: <1142974528.3470.4.camel@localhost>
	 <1143008405.13748.4.camel@homer>
	 <1144147663.2588.247.camel@elsdt-scarecrow.arc.com>
	 <200604051302.15576.tim@phipps-hutton.freeserve.co.uk>
	 <1144245205.7571.11.camel@homer>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 15:59:36 +0200
Message-Id: <1144245577.7571.16.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-05 at 13:02 +0100, Tim Phipps wrote:
> On Tuesday 04 Apr 2006 11:47, Tim Phipps wrote:
> > On Wed, 2006-03-22 at 06:20, Mike Galbraith wrote:
> > > On Wed, 2006-03-22 at 06:57 +0100, Edgar Toernig wrote:
> > > > | N60.         Processor May Hang under Certain Frequencies and 12.5%
> > > > |              STPCLK# Duty Cycle
> > > > |
> > > > | Problem:     If a system de-asserts STPCLK# at a 12.5% duty cycle,
> > > > | the processor is running below 2 GHz, and the processor thermal
> > > > | control circuit (TCC) on-demand clock modulation is active, the
> > > > | processor may hang. This erratum does not occur under the automatic
> > > > | mode of the TCC.
> >
> Here's a patch to 2.6.17-rc1 that disables the 12.5% DC on any CPU that has 
> N60. The frequencies in the errata are a bit vague so this is the safe bet 
> and it only disables one of the eight frequencies rather than the current 
> behaviour which disables all of mine!

Works for me.  Perhaps you should update...
dprintk("has errata -- disabling frequencies lower than 2ghz\n");
...,slap a Signed-off-by: on it and see if it flys.

	-Mike

P.S.  server can't find computer.systems.pipex.net: NXDOMAIN

