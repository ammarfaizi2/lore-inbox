Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266381AbUAVUBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 15:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266325AbUAVUBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 15:01:23 -0500
Received: from h00a0cca1a6cf.ne.client2.attbi.com ([65.96.182.167]:28801 "EHLO
	h00a0cca1a6cf.ne.client2.attbi.com") by vger.kernel.org with ESMTP
	id S266381AbUAVUBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 15:01:17 -0500
Date: Thu, 22 Jan 2004 15:00:44 -0500
From: timothy parkinson <t@timothyparkinson.com>
To: john stultz <johnstul@us.ibm.com>
Cc: hauan@cmu.edu, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1 "clock preempt"?
Message-ID: <20040122200044.GA593@h00a0cca1a6cf.ne.client2.attbi.com>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>, hauan@cmu.edu,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1074630968.19174.49.camel@steinar.cheme.cmu.edu> <1074633977.16374.67.camel@cog.beaverton.ibm.com> <1074697593.5650.26.camel@steinar.cheme.cmu.edu> <1074709166.16374.73.camel@cog.beaverton.ibm.com> <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com> <1074800554.21658.68.camel@cog.beaverton.ibm.com> <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com> <1074801242.21658.71.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074801242.21658.71.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


su -c "/usr/sbin/hdparm /dev/hda"
Password:

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 156301488, start = 0

but...

su -c "/usr/sbin/hdparm -d1 /dev/hda"
Password:

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

it's an 80gig western digital from about 2-3 years ago.


On Thu, Jan 22, 2004 at 11:54:02AM -0800, john stultz wrote:
> On Thu, 2004-01-22 at 11:50, timothy parkinson wrote:
> > well, it does *say* the following:
> > 
> >   ..... host bus clock speed is 133.0266 MHz.
> >   checking TSC synchronization across 2 CPUs: passed.
> >   Starting migration thread for cpu 0
> 
> That looks fine then. 
> 
> > is there a good way to check IDE PIO?
> 
> Run  "/sbin/hdparm /dev/hdX" and look for "using_dma = 0".
> 
> thanks
> -john
> 
> 
> 
> 
> 
> 
