Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272152AbTGYPQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 11:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272153AbTGYPQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 11:16:33 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:33806 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272152AbTGYPQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 11:16:32 -0400
Date: Fri, 25 Jul 2003 17:31:40 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partition check issue (againandagain??)
Message-ID: <20030725153140.GB606@win.tue.nl>
References: <20030725083152.GA1408@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030725083152.GA1408@finnendahl.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 10:31:52AM +0200, Orm Finnendahl wrote:

> Notebook with Ali15x3 Chipset, revision 195 (C3) and experience a
> freeze upon bootup at the partition check.
> 
> Kernel version <= 2.4.18 works fine on my laptop (including dma), all
> kernels > 2.4.18 lock up at boot.
> 
> The partition check line shows: 
> 
> Partition check:
> hda1 hda2 hda3 hda4 <
> 
> before it freezes. 
> 
> With the working 2.4.18 kernel the line shows:
> 
> Partition check:
> hda1 hda2 hda3 hda4 <hda5 hda6>

This sounds like your kernel succeeds in reading sector 0
but fails to read the starting sector of the extended partition.
An IDE problem, I suppose.

