Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319158AbSH2Ixe>; Thu, 29 Aug 2002 04:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319161AbSH2Ixe>; Thu, 29 Aug 2002 04:53:34 -0400
Received: from wh8043.stw.uni-rostock.de ([139.30.108.43]:6592 "EHLO
	wh8043.stw.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S319158AbSH2Ixd>; Thu, 29 Aug 2002 04:53:33 -0400
Date: Thu, 29 Aug 2002 10:56:15 +0200
From: Bjoern Krombholz <bjkro@gmx.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops while accessing /proc/stat (2.4.19)
Message-ID: <20020829085615.GB3684@wh8043.stw.uni-rostock.de>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	linux-kernel@vger.kernel.org
References: <20020826145124.GA16273@wh8043.stw.uni-rostock.de> <Pine.NEB.4.44.0208282306490.2879-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0208282306490.2879-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 11:08:24PM +0200, Adrian Bunk wrote:
> On Mon, 26 Aug 2002, Bjoern Krombholz wrote:

Hi Adrian,

> > i'm currently have a problem that every program that tries to read from
> > /proc/stat like `uptime', `free', `cat /proc/stat' etc. segfaults.
> >...
> > kernel: c01f2ad9
> > kernel: Oops: 0002
> > kernel: CPU:    0
> > kernel: EIP:    0010:[number+1049/1088]    Tainted: PF
> >...
> 
> which binary-only modules (e.g. NVidia) are loaded on your computer? Is
> the problem reproducible without them ever loaded since the last reboot?
> 

Actually it happened after the decission of not using NVidia drivers any
longer. I didn't insmod them in this session and at the time of the crash
I was happy to reach 10 days uptime (the system crashed quite often
before, every 3 to 7 days, and completely locked, so I had no chance to
get to know what these crashes were caused by).

So, NVidia wasn't the problem, but maybe VMWare. I shut VMware down a few
hours before the first Oops occured.


Bjoern


PS:
One of the `crash|lock types' that happened most often is when the system/pci
bus is on high load, e.g. copying some big files from one partition to
another one while watching TV with xawtv (standard bttv driver); or while
using "transcode" (converting video files) and whatching TV or whatching
movies. It's always the same that the system locks while reading/writing
(might be only one of those operations) to the hard disk; the HD LED keeps
on.

Maybe this is related to VIAs hardware in some way, I don't know but'd
like to. :)
