Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbVI2Gae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbVI2Gae (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 02:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVI2Gae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 02:30:34 -0400
Received: from mailgate.urz.Uni-Halle.DE ([141.48.3.51]:15763 "EHLO
	mailgate.uni-halle.de") by vger.kernel.org with ESMTP
	id S932094AbVI2Gad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 02:30:33 -0400
Date: Thu, 29 Sep 2005 08:30:26 +0200 (METDST)
From: Clemens Ladisch <clemens@ladisch.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
cc: <linux-kernel@vger.kernel.org>, Bob Picco <bob.picco@hp.com>
Subject: Re: [PATCH 5/7] HPET-RTC: disable interrupt when no longer needed
In-Reply-To: <20050928060306.A26313@unix-os.sc.intel.com>
Message-ID: <Pine.HPX.4.33n.0509290828210.4137-100000@studcom.urz.uni-halle.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scan-Signature: 44699ef9896cba58db3267a1f0641b2b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi wrote:
> On Wed, Sep 28, 2005 at 09:12:26AM +0200, Clemens Ladisch wrote:
> > When the emulated RTC interrupt is no longer needed, we better disable
> > it; otherwise, we get a spurious interrupt whenever the timer has
> > rolled over and reaches the same comparator value.
> >
> > Having a superfluous interrupt every five minutes doesn't hurt much,
> > but it's bad style anyway.  ;-)
>
> Do you really see the interrupt every five minutes once RTC is disabled.

Yes; at least on my Intel chipset.  ;-)

> I had assumed while in one-shot interrupt mode, HPET would automatically unarm
> after generating the interrupt, so that we won't get interrupts any more.

The spec never mentions this.  What it mentions is that it was
designed so that it can be implemented in as few gates as possible.


Regards,
Clemens

