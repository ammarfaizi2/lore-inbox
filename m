Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132696AbRDKSCG>; Wed, 11 Apr 2001 14:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132690AbRDKSB4>; Wed, 11 Apr 2001 14:01:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55310 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132689AbRDKSBs>; Wed, 11 Apr 2001 14:01:48 -0400
Subject: Re: announce: PPSkit patch for Linux 2.4.2 (pre6)
To: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 11 Apr 2001 19:03:47 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9b25rh$rav$1@cesium.transmeta.com> from "H. Peter Anvin" at Apr 11, 2001 10:56:01 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nOy5-0007Ei-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> appropriately.)  One could, at least theoretically, make them usable
> in kernel space only (in user space there is no hope, since you can't
> know which CPU's TSC you're reading), but these machines seem to be so
> rare that hardly anyone technical enough to fix it cares.

Im working on making the 'notsc' automatic. Trying to 'fix' it is just plain
hard work. With the fixed one however we can still use the tsc for udelay
as we have per cpu loops_per_jiffy data.

This btw is why -ac figures out the bus multiplier on your processors. If they
dont match then we know tsc wants to be off. Just nobody has written the code
to disable it across all CPUs yet

