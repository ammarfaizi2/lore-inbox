Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268406AbUJGVVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268406AbUJGVVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269772AbUJGVUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:20:14 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:12758 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S268107AbUJGVKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:10:21 -0400
Subject: Re: 2.6.9rc2-mm4 oops
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Len Brown <len.brown@intel.com>, acpi-devel@lists.sourceforge.net,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <200410071431.20400.bjorn.helgaas@hp.com>
References: <1096571653.11298.163.camel@cmn37.stanford.edu>
	 <1096653158.7485.17.camel@cmn37.stanford.edu>
	 <200410011633.10171.bjorn.helgaas@hp.com>
	 <200410071431.20400.bjorn.helgaas@hp.com>
Content-Type: text/plain
Organization: 
Message-Id: <1097183386.3310.261.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Oct 2004 14:09:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-07 at 13:31, Bjorn Helgaas wrote:
> On Friday 01 October 2004 4:33 pm, Bjorn Helgaas wrote:
> > On Friday 01 October 2004 11:52 am, Fernando Pablo Lopez-Lezcano wrote:
> > > On Fri, 2004-10-01 at 08:04, Bjorn Helgaas wrote:
> > > >  Also, can you look up the bad address
> > > > (e.g., f8881920) in /proc/kallsyms? 
> > > 
> > > This is what I find:
> > > f8880f80 ? __mod_vermagic5      [xor]
> > > f8880fcd ? __module_depends     [xor]
> > > f8881000 t acpi_button_init     [button]
> > > f8881000 t init_module  [button]
> > > f8884000 t xor_pII_mmx_2        [xor]
> > > f8884130 t xor_pII_mmx_3        [xor]
> > 
> > You are remembering that /proc/kallsyms isn't sorted, right?
> > 
> > If you still can't match the address to anything interesting,
> > can you see whether it's related to any of the other modules
> > (i.e., see whether it happens even if you don't load any of
> > the other ACPI drivers, or try leaving out any other drivers
> > you can get along without)?  Maybe try loading an ACPI driver
> > other than floppy, at the same point in the module load sequence,
> > to see if the problem is specific to floppy, or if floppy is
> > just an innocent bystander?
> > 
> > I looked at all the callers of acpi_bus_register_driver(), and
> > they all look fine (except the hpet one I found yesterday).  But
> > maybe there's something I missed, or maybe the acpi_bus_drivers
> > list got corrupted somehow.
> > 
> > If you don't load the floppy driver, is the system stable?

Even if I load it (unsuccesfully - there's actually no floppy) the
system _appears_ to be fine. If I remember correctly this happens in the
context of device discovery (kudzu). 

> Any update on all this?  I've tried to reproduce the problem on
> my Athlon box, but so far I've been unsuccessful.

Sorry for the delay, too busy as usual. 

BTW, what I sent was actually sorted. I'll see if I can get more
information later today (I have not forgotten). 

-- Fernando


