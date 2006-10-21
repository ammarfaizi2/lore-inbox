Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWJUEKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWJUEKF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 00:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWJUEKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 00:10:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:17379 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751413AbWJUEKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 00:10:03 -0400
Date: Fri, 20 Oct 2006 20:55:00 -0700
From: Greg KH <greg@kroah.com>
To: Andi Kleen <ak@suse.de>
Cc: artusemrys@sbcglobal.net, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       linux-kernel@vger.kernel.org, Dave Airlie <airlied@linux.ie>,
       akpm@osdl.org
Subject: Re: 2.6.19-rc2-mm2
Message-ID: <20061021035500.GB10522@kroah.com>
References: <20061020015641.b4ed72e5.akpm@osdl.org> <p734ptybk0z.fsf@verdi.suse.de> <20061021005014.GC12131@kroah.com> <200610210413.40401.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610210413.40401.ak@suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2006 at 04:13:40AM +0200, Andi Kleen wrote:
> 
> > Yeah, real numbers would be good to have.  I have measured 7-8 seconds
> > off the boot on my workstation, and 2 seconds off the boot for my
> > laptop.  All of the time saved seems to be due to slow SATA startup
> > times, and the machine is off initializing other things while that is
> > happening.
> 
> So perhaps it would be a safer strategy to just run the SATA probing in the
> background and keep the rest serialized? 

That would work for my machines, but what about everyone else?  SCSI
should also be faster, and perhaps other PCI drivers that take a while
in initialization.

Anyway, it does help some people out.

thanks,

greg k-h
