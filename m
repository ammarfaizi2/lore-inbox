Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSJUWSR>; Mon, 21 Oct 2002 18:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSJUWSR>; Mon, 21 Oct 2002 18:18:17 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:3896 "EHLO
	flossy.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261740AbSJUWSQ>; Mon, 21 Oct 2002 18:18:16 -0400
Date: Mon, 21 Oct 2002 18:25:00 -0400
From: Doug Ledford <dledford@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matt_Domsch@Dell.com, andmike@us.ibm.com, cliffw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-megaraid-devel@Dell.com
Subject: Re: 2.5.44 compile problem: MegaRAID driver
Message-ID: <20021021222500.GK28914@redhat.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt_Domsch@Dell.com,
	andmike@us.ibm.com, cliffw@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-megaraid-devel@Dell.com
References: <20BF5713E14D5B48AA289F72BD372D68C1EA2E@AUSXMPC122.aus.amer.dell.com> <1035239507.27309.259.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035239507.27309.259.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 11:31:47PM +0100, Alan Cox wrote:
> On Mon, 2002-10-21 at 23:10, Matt_Domsch@Dell.com wrote:
> > The host reordering is to solve the same problem that EDD helps us solve now
> > - it makes sure that in systems with megaraid adapters that also have BIOS
> > enabled (thus have the bootable logical drive on that card) that it shows up
> 
> You can fix the ordering up still if you want within cards of a given
> driver type. i2o does this to get its bios boot volume first. Just do it
> by probing your devices, then registering them in the order you want,
> not by mashing the list

This is, umm, a non-elegant way of handling things once you switch your 
driver to the new PCI driver probe model :-(

Of course, I'm personally of the opinion that people need to quite 
thinking in terms of host order anyway and let things like mount by volume 
solve this issue anyway.  It's cleaner, it works regardless of the driver, 
and it puts the burden of finding the right root partition in user space 
where it's easier to fix up should things change, etc.  Just my opinion.

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
