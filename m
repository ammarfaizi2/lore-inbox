Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263353AbRFAEKQ>; Fri, 1 Jun 2001 00:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263357AbRFAEKH>; Fri, 1 Jun 2001 00:10:07 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:33133 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263353AbRFAEJy>; Fri, 1 Jun 2001 00:09:54 -0400
Date: Fri, 1 Jun 2001 00:09:53 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200106010409.f5149rl25342@devserv.devel.redhat.com>
To: thockin@sun.com, alan@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (for real this  time)
In-Reply-To: <mailman.991363680.24671.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.991363680.24671.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Aattached is a (large, but self contained) patch for Cobalt Networks suport
> for x86 systems (RaQ3, RaQ4, Qube3, RaQXTR).  Please let me know if there
> is anything that would prevent this from general inclusion in the next
> release.

Looks interesting. Seemingly literate use of spinlocks.

Off-hand I see old style initialization. Is it right for new driver?

i2c framework is not used, I wonder why. Someone thought that
it was too heavy perhaps? If so, I disagree.

Also, I am curious
if any alignment with lm-sensors is possible, for the sake of
common userland tools? If we managed that, PSARC would eat their
hearts out - they tried to do it since E-250 shipped.

lcd_read bounces reads with -EINVAL when another read is in
progress. Gross.

Nitpicking:

1.:
	p = head;
	while (p) {
		p = p->next;
	}

It is what for(;;) does.

2. Spaces and tabs are mixed in funny ways, makes to cute effects
when quoting diffs.

-- Pete
