Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317423AbSFHS35>; Sat, 8 Jun 2002 14:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317427AbSFHS34>; Sat, 8 Jun 2002 14:29:56 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:37511 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317423AbSFHS3z>; Sat, 8 Jun 2002 14:29:55 -0400
Date: Sat, 8 Jun 2002 20:29:45 +0200
To: Mukesh Rajan <mrajan@ics.uci.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HDD power states + kernel
Message-ID: <20020608182945.GA2451@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Mukesh Rajan <mrajan@ics.uci.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020607205114Z317348-22021+121@vger.kernel.org> <Pine.SOL.4.20.0206071355570.16596-100000@hobbit.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2002 at 02:05:05PM -0700, Mukesh Rajan wrote:
> i need to implement powering down of the Hard Disk in the linux kernel. i
> understand that using "hdparm" i could set a timeout and power down the
> HDD after a certain idle time.
> 
> but then HDD has 4 power states and instead of powering down to the lowest
> power state, i would like to power down one state at a time based on
> certain timeout values.  
> 
> i'm not sure where to start with this. would i have to play around with
> "llrwblk.c"? and what would i have to do here in order to monitor disk
> inactivity (idleness)? or should i look into APM stuff?

The various standby modes of IDE disks are exported to userland via
ioctl()s (WIN_STANDBYNOW* and friends).  For a userland solution see
http://noflushd.sourceforge.net.  A first stab at a kernel
implementation was recently posted by Andrew Morton to linux-kernel
(June 4th, look out for "laptop mode").  Neither code makes use of
multiple power states, but you could start hacking from there.

Regards,

Daniel.
