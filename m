Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVA1RAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVA1RAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVA1RAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:00:13 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52119 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261328AbVA1RAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:00:07 -0500
Subject: Re: Where Linux 802.11x support needs work
From: Dan Williams <dcbw@redhat.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200501281638.08372.m.watts@eris.qinetiq.com>
References: <Pine.LNX.4.58.0501251630280.30850@devserv.devel.redhat.com>
	 <200501281638.08372.m.watts@eris.qinetiq.com>
Content-Type: text/plain
Date: Fri, 28 Jan 2005 12:00:03 -0500
Message-Id: <1106931603.3051.8.camel@dcbw.boston.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 16:38 +0000, Mark Watts wrote:
> > o  Firmware issues
> >    1) Cisco aironet firmware upload is quite inconsistent, fails with
> >       5.21 for example.  Firmware <= 5.02 seems to be required for using
> >       WEP with most access points.  Latest Cisco-provided driver is quite
> >       different than latest in-kernel driver
> 
> This might explain why I've never managed to get WEP working with my cisco 
> cards...
> 
> Is there some documentation somewhere on exactly what firmware/driver/kernel 
> versions you need to make WEP work with aironet cards?

Nope.  Cisco-provided drivers (for 2.4-series kernels only) require a
firmware version of 5.30.17.  The in-kernel drivers for the 2.6 series
don't have the updates necessary to work with that version, and it
appears that versions of the firmware that are higher than 5.20.x will
not work for WEP using the in-kernel drivers.

I have personally tried 5.41 and 5.30.17 on a PCMCIA card and found they
do _not_ work with WEP.  I have also tried versions 5.00.01, 5.02.13,
5.00.03, and 5.20.07 (?) on both PCMCIA and MiniPCI cards and found them
to work correctly with WEP-enabled access points.

Dan

