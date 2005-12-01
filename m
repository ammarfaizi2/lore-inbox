Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVLAVSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVLAVSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVLAVSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:18:50 -0500
Received: from mx1.suse.de ([195.135.220.2]:47274 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932484AbVLAVSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:18:49 -0500
Date: Thu, 1 Dec 2005 22:18:48 +0100
From: Andi Kleen <ak@suse.de>
To: Erwin Rol <mailinglists@erwinrol.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: Display HPET timer option
Message-ID: <20051201211848.GE997@wotan.suse.de>
References: <Pine.LNX.4.64.0512011143350.13220@montezuma.fsmlabs.com> <Pine.LNX.4.64.0512011150110.3099@g5.osdl.org> <Pine.LNX.4.64.0512011216200.13220@montezuma.fsmlabs.com> <20051201204339.GC997@wotan.suse.de> <1133471197.3604.3.camel@xpc.home.erwinrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133471197.3604.3.camel@xpc.home.erwinrol.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 10:06:37PM +0100, Erwin Rol wrote:
> On Thu, 2005-12-01 at 21:43 +0100, Andi Kleen wrote:
> > On Thu, Dec 01, 2005 at 12:30:03PM -0800, Zwane Mwaikambo wrote:
> > > On Thu, 1 Dec 2005, Linus Torvalds wrote:
> > > 
> > > > On Thu, 1 Dec 2005, Zwane Mwaikambo wrote:
> > > > >
> > > > > Currently the HPET timer option isn't visible in menuconfig.
> > > > 
> > > > Do you want it to?
> > > > 
> > > > Why would you ever compile it out?
> > > 
> > > For timer testing purposes i sometimes would like not to use the HPET. 
> > > Would a runtime switch be preferred?
> > 
> > nohpet already exists.
> > 
> 
> And luckily it does cause without "nohpet" i can't boot my shuttle
> ST20G5, the NMI watchdog kills it because ti hangs when initializing the
> hpet. If the nmi watchdog is off it just hangs for ever. 

Can you give details on the machine? lspci, dmidecode, acpidmp output,
boot log from the hang case?

Then perhaps it can be blacklisted or the failure otherwise avoided.

[Looks like I finally need to add DMI decode support to x86-64 too :-/]

-Andi

