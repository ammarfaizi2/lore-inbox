Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbTIKSo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 14:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbTIKSo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 14:44:57 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:45202 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261453AbTIKSox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 14:44:53 -0400
Subject: Re: Problem: IDE data corruption with VIA chipsets
	on2.4.20-19.8+others
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Bickle <ebickle@healthspace.ca>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <001601c37891$660cc5d0$5d74ad8e@hyperwolf>
References: <001601c37891$660cc5d0$5d74ad8e@hyperwolf>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063305812.3606.4.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 19:43:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-11 at 19:20, Eric Bickle wrote:
> > > kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> > > kernel: hdc: dma_intr: error=0x40 { UncorrectableError },
> LBAsect=150637065,
> > > sector=150636992
> >
> > This is a physical failure from the hard disk *NOT* a Linux problem
> 
> That's exactially what I thought when I first saw the problem as well.
> 
> However, we had about 16-20 different drives show up with the problem, about
> 3 different brands too. I did some low-level tests on the drives that linux
> had an error on and none of my diagnostic tools could find any problems.
> 
> Any ideas?

Other than to tell you Linux is simply reporting back what the drive
itself reported - which is a physical failure to recover a sector of
data no.

A test that rewrites such a sector will generally clear the error, its
one of the problems of some diagnostic tools. A pure read test should
fine the error again unless its something like overheat causing the
problem. SMART data will tell you drive temperatures

