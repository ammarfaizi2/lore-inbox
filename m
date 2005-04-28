Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVD1SrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVD1SrF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVD1SrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:47:05 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:47437 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262210AbVD1SrB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:47:01 -0400
Subject: Re: Extremely poor umass transfer rates
From: Mark Rosenstand <mark@ossholes.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4271292F.1000002@grupopie.com>
References: <1114704142.8410.4.camel@mjollnir.bootless.dk>
	 <20050428165915.GG30768@redhat.com>
	 <1114710941.8326.13.camel@mjollnir.bootless.dk>
	 <20050428110614.00a0c193.rddunlap@osdl.org> <4271292F.1000002@grupopie.com>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 20:47:12 +0200
Message-Id: <1114714032.8326.27.camel@mjollnir.bootless.dk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 19:19 +0100, Paulo Marques wrote:
> > | The line that 'hald' puts in fstab looks like this:
> > | 
> > | 	/dev/sdb /media/usbdisk vfat \
> > | 		user,exec,noauto,utf8,noatime,sync,managed 0 0
> 
> The "sync" flag is what is killing your performance. It is needed if you 
> intend to remove your usb pen without warning, but if you are going to 
> unmount carefully you don't need it at all.
> 
> Try mounting the device as root somewhere else without the "sync" flag 
> and measure the performance that way, to see the difference.

Wow. That seems to speed things up alot. However I can't unmount it
again, I keep getting "umount: /media/usbdisk: device is
busy" (twice(?)). It's been 5 minutes since I did the transfer (4 MB
file) now.

> I hope this helps,

It sure did. Thanks!

-- 
  .-.    Mark Rosenstand        (-.)
  oo|                           cc )
 /`'\    (+45) 255 31337      3-n-(
(\_;/)   mark@geekworld.org    _(|/`->

