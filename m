Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266256AbTAFHVp>; Mon, 6 Jan 2003 02:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTAFHVp>; Mon, 6 Jan 2003 02:21:45 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:43699 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266256AbTAFHVn>;
	Mon, 6 Jan 2003 02:21:43 -0500
Date: Mon, 6 Jan 2003 13:02:04 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx broken in 2.5.53/54 ?
Message-ID: <20030106073204.GA1875@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030103101618.GB8582@in.ibm.com> <596830816.1041606846@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <596830816.1041606846@aslan.scsiguy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

On Fri, Jan 03, 2003 at 08:14:06AM -0700, Justin T. Gibbs wrote:
> > Looks like the aic7xxx driver in 2.5.53 and 54 are broken on my hardware.
> 
> It looks like the driver recovers fine.

Not for long. It dies shortly afterwards.

> > aic7xxx: PCI Device 0:1:0 failed memory mapped test.  Using PIO.
> > Uhhuh. NMI received for unknown reason 25 on CPU 0.
> 
> SERR must be enabled by your BIOS.  I will change the driver so
> that, should the memory mapped I/O test fail, an SERR (and thus an
> NMI) is not generated.

I guess having to use PIO with aic7xxx is bad. MMIO failure is
what we need to investigate.

> 
> Just out of curiosity, do you have any strange PCI options enabled
> in your BIOS?  I remeber seeing memory mapped I/O failures on this
> ServerWorks chipset under FreeBSD in the past, but an updated BIOS
> resolved the issue for the affected users.  It seemed that the BIOS
> incorrectly placed the Adaptec controller in a prefetchable region.
> 

I didn't change anything in that box since it was delivered to me. FYI
it is an IBM x250. Would it help if I can get a PCI space dump and mtrr 
dump ? FWIW, the older driver works fine. Does the older driver use 
only PIO ?

Thanks
Dipankar
