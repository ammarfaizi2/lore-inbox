Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271352AbTHRJAS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 05:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271353AbTHRJAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 05:00:18 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:40406 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S271352AbTHRJAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 05:00:15 -0400
Date: Mon, 18 Aug 2003 13:00:26 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: kenton.groombridge@us.army.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: nforce2 lockups
Message-ID: <20030818130026.C1423@beton.cybernet.src>
References: <7a3f387a6ef2.7a6ef27a3f38@us.army.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <7a3f387a6ef2.7a6ef27a3f38@us.army.mil>; from kenton.groombridge@us.army.mil on Mon, Aug 18, 2003 at 05:04:20PM +0900
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a hunch: is it possible that gcc is compiling something a bit wrong?
> I know that some instructions when processed in a certain order, can do some
> wacky things.  Maybe a gcc bug is causing the Athlon processor to caculate
> some instructions in the right sequence where it sometimes works, and other
> times doesn't.
> 
> The reason I say this, is that I have read a few posts where one person had
> lock-ups with one distro and not the other.  Kernels are pretty much the same
> (I think we are all downloading the latest kernel source and building our own
> kernels), but gcc is different.

I realized that when I recompiled kernel from 2.4.21 to 2.6.0 it could
still be crashed on-demand. But when I replaced the 2.4.21 back it wouldn't
crash. But in meantime, when I replaced the IDE disk for another with the
same kernel, the crash could still be done on-demand.

I tried to copy the swap (disk map: 1G swap @ the beginning, ext2 the rest)
from the crashdisk to noncrashdisk verbatim if it's not dependent on the
content read (the crash was within first 10 seconds, with 40MB/s it's less than
400M from the beginning of the disk) and it didn't help. It seems it is highly
dependent on a sequence of some highly irrelevant operations during the startup
of the kernel.

> 
> Haven't tried it yet, since I am working a project 24/7 that will keep me
> until the end of the month.  Purchased the Athlon XP Gentoo 1.4 CDs, so will
> load then and may get some different results.
> 
> Ken
> 
