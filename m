Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130266AbRCGGNG>; Wed, 7 Mar 2001 01:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130260AbRCGGM5>; Wed, 7 Mar 2001 01:12:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:52494 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130145AbRCGGMt>; Wed, 7 Mar 2001 01:12:49 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Kernel 2.4.3 and new aic7xxx
Date: 6 Mar 2001 22:11:45 -0800
Organization: Transmeta Corporation
Message-ID: <984jf1$1hj$1@penguin.transmeta.com>
In-Reply-To: <3AA5CA13.8C19FC7E@neuronet.pitt.edu> <200103070546.f275keO22502@aslan.scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200103070546.f275keO22502@aslan.scsiguy.com>,
Justin T. Gibbs <gibbs@scsiguy.com> wrote:
>>I've a Super P6SBS motherboard with a builtin dual channel Adaptec 7890
>>Ultra II scsi controller. I'm attaching the console grab when booting
>>2.4.3-pre2. The controller BIOS is configured to boot off the disk with
>>scsi id 0 on channel B.
>
>It looks like Doug was right to think that the functions can be
>presented to the device driver in reverse order.  I should have
>a patch for you early tomorrow.

It should be easy enough to make the PCI layer sort the devices, and you
might not be the only driver that wants to see subfunction 0 before
subfunction 1.

I suspect it's easier to just make the PCI layer call the probe function
in that order, instead of working around it in your driver. Jeff?

		Linus
