Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbRHOVnH>; Wed, 15 Aug 2001 17:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266982AbRHOVm5>; Wed, 15 Aug 2001 17:42:57 -0400
Received: from t2.redhat.com ([199.183.24.243]:38896 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S266921AbRHOVmv>; Wed, 15 Aug 2001 17:42:51 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <997911115.7088.4.camel@keller> 
In-Reply-To: <997911115.7088.4.camel@keller>  <997905442.2135.6.camel@keller> <997901702.2129.16.camel@keller> <29219.997909757@redhat.com> 
To: Georg Nikodym <georgn@somanetworks.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Dell I8000, 2.4.8-ac5 and APM 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Aug 2001 22:42:57 +0100
Message-ID: <30038.997911777@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


georgn@somanetworks.com said:
>  To be honest, I don't really use suspend/resume so I can't answer.  I
> did, however, get it working for myself while at OLS (under
> 2.4.6-ext3). The trick there was remove my PCMCIA (3c59x) network card
> and keep it in my knapsack for the duration of the conference. 

This one has the built-in eepro100. That goes AWOL on suspend too, but 
that's solved by saving the PCI configuration space on suspend and 
restoring it on resume because their BIOS is too crap to do it for us.

> > Strangely, APM suspend was working after a suspend-to-disk. It only
> > failed after a clean boot.

> Curious, indeed.

Confused me quite a lot, that one. Adding the suspend-to-disk partition to
the Grub menu and then suspending it halfway through booting - NB _before_
it's mounted the rootfs - lets me susequently boot directly into a state
where APM suspend will work :)

--
dwmw2


