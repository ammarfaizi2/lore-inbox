Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267797AbUG3TeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267797AbUG3TeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 15:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267802AbUG3TeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 15:34:24 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:5248 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S267804AbUG3TeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 15:34:22 -0400
Date: Fri, 30 Jul 2004 21:35:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Exposing ROM's though sysfs
Message-ID: <20040730193546.GA328@ucw.cz>
References: <200407301010.29807.jbarnes@engr.sgi.com> <20040730192510.74857.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730192510.74857.qmail@web14922.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 12:25:10PM -0700, Jon Smirl wrote:
> --- Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > How about this patch?
> 
> Here's the ROM access code I've been using but it's not in the form
> that we need.
> 
> We do need a standard scheme for the radeon situation of having a bug
> in the ROM access logic. Is it ok to put the fix for this in the radeon
> driver? So if you read the ROM before the driver is loaded it won't be
> there (proabably FFFF's). After the driver loads the fix will run as
> part of the driver init and the ROM access functions will work right. 

IMO the fix should go to the PCI quirk logic. That's a place to work
around PCI config bugs.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
