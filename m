Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264173AbUD2MAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbUD2MAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbUD2MAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:00:45 -0400
Received: from mail.shareable.org ([81.29.64.88]:42624 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264173AbUD2MAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:00:44 -0400
Date: Thu, 29 Apr 2004 13:00:17 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Ross Dickson <ross@datscreative.com.au>,
       Jesse Allen <the3dfxdude@hotmail.com>, Len Brown <len.brown@intel.com>,
       a.verweij@student.tudelft.nl,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Craig Bradney <cbradney@zip.com.au>, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH] for idle=C1halt, 2.6.5
Message-ID: <20040429120017.GB7077@mail.shareable.org>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl> <200404282133.34887.ross@datscreative.com.au> <20040428205938.GA1995@tesore.local> <200404292144.37479.ross@datscreative.com.au> <Pine.LNX.4.55.0404291352200.11691@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0404291352200.11691@jurand.ds.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:
>  Not necessarily related to the PSU, but the noise may actually be the
> reason of spurious timer interrupts.

With most device interrupts, additional spurious ones don't cause any
malfunction because the driver's handler checks whether the device
actually has a condition pending.

This is the basis of shared interrupts, of course.

Is there any way we can check the timer itself to see whether an
interrupt was caused by it, so that spurious timer interrupts are ignored?

-- Jamie
