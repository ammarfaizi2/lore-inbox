Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSLYViE>; Wed, 25 Dec 2002 16:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSLYViE>; Wed, 25 Dec 2002 16:38:04 -0500
Received: from m83-mp1.cvx2-c.ren.dial.ntli.net ([62.252.152.83]:42229 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S261356AbSLYViD>; Wed, 25 Dec 2002 16:38:03 -0500
Subject: Re: [PATCH] Fix CPU bitmask truncation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bjorn Helgaas <bjorn_helgaas@hp.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andreas Schwab <schwab@suse.de>
In-Reply-To: <200212201000.21223.bjorn_helgaas@hp.com>
References: <200212161213.29230.bjorn_helgaas@hp.com>
	<20021220103028.GB9704@holomorphy.com>
	<20021220111523.GA7644@holomorphy.com> 
	<200212201000.21223.bjorn_helgaas@hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Dec 2002 21:43:08 +0000
Message-Id: <1040852588.1770.35.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-12-20 at 17:00, Bjorn Helgaas wrote:
> This was an issue with gcc 2.96 on a 64-way IA64 box.  I don't have
> access to one at the moment, but as I remember, without the 2.4 changes:
> 
> -       ((p)->cpus_runnable & (p)->cpus_allowed & (1 << cpu))
> +       ((p)->cpus_runnable & (p)->cpus_allowed & (1UL << cpu))
> 
> nothing would get scheduled on CPUs 32-63.  I guess those changes
> aren't controversial, though.

Is this a C quirk or a compiler bug ? 

