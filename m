Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVBPXsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVBPXsy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:48:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVBPXsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:48:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:43492 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262134AbVBPXry convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:47:54 -0500
Date: Wed, 16 Feb 2005 15:52:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: noel@zhtwn.com, torvalds@osdl.org, kas@fi.muni.cz, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
Message-Id: <20050216155255.0ffab555.akpm@osdl.org>
In-Reply-To: <200502160107.08039.kernel-stuff@comcast.net>
References: <20050121161959.GO3922@fi.muni.cz>
	<200502152300.15063.kernel-stuff@comcast.net>
	<20050215211210.1ea2d342.akpm@osdl.org>
	<200502160107.08039.kernel-stuff@comcast.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> wrote:
>
> On Wednesday 16 February 2005 12:12 am, Andrew Morton wrote:
> > Plenty of moisture there.
> >
> > Could you please use this patch?  Make sure that you enable
> > CONFIG_FRAME_POINTER (might not be needed for __builtin_return_address(0),
> > but let's be sure).  Also enable CONFIG_DEBUG_SLAB.
> 
> Will try that out. For now I tried -rc4 and couple other things - removing 
> nvidia module doesnt make any difference but removing ndiswrapper and with no 
> networking the slab growth stops. With 8139too driver and network the growth 
> is there but pretty slower than with ndiswrapper. With 8139too + some network 
> activity slab seems to reduce sometimes.

OK.

> Seems either an ndiswrapper or a networking related leak. Will report the 
> results with Manfred's patch tomorrow.

So it's probably an ndiswrapper bug?
