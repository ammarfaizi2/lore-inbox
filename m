Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318503AbSGaVFR>; Wed, 31 Jul 2002 17:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318505AbSGaVFR>; Wed, 31 Jul 2002 17:05:17 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:13565 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318503AbSGaVEg>; Wed, 31 Jul 2002 17:04:36 -0400
Date: Wed, 31 Jul 2002 17:08:02 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc3aa4
Message-ID: <20020731170802.R10270@redhat.com>
References: <20020730060218.GB1181@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020730060218.GB1181@dualathlon.random>; from andrea@suse.de on Tue, Jul 30, 2002 at 08:02:18AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 08:02:18AM +0200, Andrea Arcangeli wrote:
> 	Merged async-io from Benjamin LaHaise after purifying it from the
> 	/proc/libredhat.so mess that made it not binary compatible with 2.5.
> 
> 	While merging I did a number of cleanups and fixes, to mention a few of
> 	them I fixed a shell root exploit in map_user_kvect by using
> 	get_user_pages (that honours VM_MAYWRITE), it avoids corruption of
> 	KM_IRQ0 by doing spin_lock_irq in aio_read_evt, and a number of other
> 	minor not security and not stability related changes.  Left out the
> 	networking async-io, it can be merged trivially at a later stage (if
> 	needed :).

Care to explain the problem and provide a separate patch for all the 
people who aren't using your tree of patches?  If there's a problem 
as you claim, then it likely affects map_user_kiobuf too.

		-ben
