Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262124AbVBPXbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbVBPXbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 18:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVBPXbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 18:31:52 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29106 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262124AbVBPXbv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 18:31:51 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
Date: Wed, 16 Feb 2005 01:07:06 -0500
User-Agent: KMail/1.7.92
Cc: noel@zhtwn.com, torvalds@osdl.org, kas@fi.muni.cz, axboe@suse.de,
       linux-kernel@vger.kernel.org
References: <20050121161959.GO3922@fi.muni.cz> <200502152300.15063.kernel-stuff@comcast.net> <20050215211210.1ea2d342.akpm@osdl.org>
In-Reply-To: <20050215211210.1ea2d342.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200502160107.08039.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 February 2005 12:12 am, Andrew Morton wrote:
> Plenty of moisture there.
>
> Could you please use this patch?  Make sure that you enable
> CONFIG_FRAME_POINTER (might not be needed for __builtin_return_address(0),
> but let's be sure).  Also enable CONFIG_DEBUG_SLAB.

Will try that out. For now I tried -rc4 and couple other things - removing 
nvidia module doesnt make any difference but removing ndiswrapper and with no 
networking the slab growth stops. With 8139too driver and network the growth 
is there but pretty slower than with ndiswrapper. With 8139too + some network 
activity slab seems to reduce sometimes.

Seems either an ndiswrapper or a networking related leak. Will report the 
results with Manfred's patch tomorrow.

Thanks
Parag
