Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266346AbUAVVVx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 16:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUAVVVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 16:21:53 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:24786 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266346AbUAVVVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 16:21:51 -0500
Subject: Re: 2.6.1 "clock preempt"?
From: john stultz <johnstul@us.ibm.com>
To: timothy parkinson <t@timothyparkinson.com>
Cc: hauan@cmu.edu, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040122200044.GA593@h00a0cca1a6cf.ne.client2.attbi.com>
References: <1074630968.19174.49.camel@steinar.cheme.cmu.edu>
	 <1074633977.16374.67.camel@cog.beaverton.ibm.com>
	 <1074697593.5650.26.camel@steinar.cheme.cmu.edu>
	 <1074709166.16374.73.camel@cog.beaverton.ibm.com>
	 <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074800554.21658.68.camel@cog.beaverton.ibm.com>
	 <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074801242.21658.71.camel@cog.beaverton.ibm.com>
	 <20040122200044.GA593@h00a0cca1a6cf.ne.client2.attbi.com>
Content-Type: text/plain
Message-Id: <1074806504.21658.76.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 22 Jan 2004 13:21:45 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-22 at 12:00, timothy parkinson wrote:
> su -c "/usr/sbin/hdparm /dev/hda"
> Password:
> 
> /dev/hda:
>  multcount    = 16 (on)
>  IO_support   =  1 (32-bit)
>  unmaskirq    =  0 (off)
>  using_dma    =  0 (off)
>  keepsettings =  0 (off)
>  readonly     =  0 (off)
>  readahead    = 256 (on)
>  geometry     = 65535/16/63, sectors = 156301488, start = 0
> 
> but...
> 
> su -c "/usr/sbin/hdparm -d1 /dev/hda"
> Password:
> 
> /dev/hda:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)
> 
> it's an 80gig western digital from about 2-3 years ago.

Its likely you need to enable support in the kernel for your IDE
controller, or your DMA on your controller isn't supported. 

thanks
-john

