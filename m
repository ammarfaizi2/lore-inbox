Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992781AbWJUByD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992781AbWJUByD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 21:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992783AbWJUByD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 21:54:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:5309 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S2992781AbWJUByA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 21:54:00 -0400
Date: Fri, 20 Oct 2006 17:50:14 -0700
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: artusemrys@sbcglobal.net, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
       akpm@osdl.org
Subject: Re: 2.6.19-rc2-mm2
Message-ID: <20061021005014.GC12131@kroah.com>
References: <20061020015641.b4ed72e5.akpm@osdl.org> <200610201339.49190.m.kozlowski@tuxland.pl> <20061020091901.71a473e9.akpm@osdl.org> <200610201854.43893.m.kozlowski@tuxland.pl> <20061020102520.67b8c2ab.akpm@osdl.org> <45394F97.9010401@sbcglobal.net> <p734ptybk0z.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p734ptybk0z.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 02:16:28AM +0200, Andi Kleen wrote:
> Matthew Frost <artusemrys@sbcglobal.net> writes:
> 
> > Andrew Morton wrote:
> > 
> > > Ow.  Multithreaded probing was probably a bt ambitious, given the current
> > > status of kernel startup..
> > > 
> > > Greg, does it actually speed anything up or anything else good?
> > > 
> > 
> > I'm on a x86 (P4) hi-mem machine, plenty of onboard PCI (audio, LAN, bonus IDE
> > controller, etc.), and it has sped up my boot process.  Between the USB and PCI
> > multithread probing, my dmesg is a bit out of order from its ordinary sequence,
> > but the only things that stall it now are my MD-RAID partitions getting set up.
> 
> Did you measure it?  Feelings and impressions tend to be unreliable.

Yeah, real numbers would be good to have.  I have measured 7-8 seconds
off the boot on my workstation, and 2 seconds off the boot for my
laptop.  All of the time saved seems to be due to slow SATA startup
times, and the machine is off initializing other things while that is
happening.

thanks,

greg k-h
