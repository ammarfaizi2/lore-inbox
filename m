Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267302AbUG2Ivk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267302AbUG2Ivk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 04:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUG2Ivk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 04:51:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:419 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S267302AbUG2Ivf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 04:51:35 -0400
Date: Thu, 29 Jul 2004 10:49:29 +0200
From: Jens Axboe <axboe@suse.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Dave Jones <davej@redhat.com>,
       Edward Angelo Dayao <edward.dayao@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Recent 2.6 kernels can't read an entire ATAPI CD or DVD
Message-ID: <20040729084928.GR10377@suse.de>
References: <1090989052.3098.6.camel@camp4.serpentine.com> <20040728053107.GB11690@suse.de> <c93051e8040727235123a6ed67@mail.gmail.com> <20040728065319.GD11690@suse.de> <20040728145228.GA9316@redhat.com> <20040728145543.GB18846@devserv.devel.redhat.com> <20040728163353.GJ10377@suse.de> <20040728170507.GK10377@suse.de> <1091051858.13651.1.camel@camp4.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091051858.13651.1.camel@camp4.serpentine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28 2004, Bryan O'Sullivan wrote:
> On Wed, 2004-07-28 at 19:05 +0200, Jens Axboe wrote:
> 
> > On this thread, I agree it's
> > probably a kernel issue. Can you check what capacity isosize gives you
> > on the device, and what /proc/ide/hdc/capacity tells you?
> 
> This is a basically unpatched 2.6.7 kernel:
> 
> ~ # uname -a
> Linux abcd.serpentine.com 2.6.7-1.1791-up #1 Sat Jul 10 14:22:15 PDT
> 2004 i686 athlon i386 GNU/Linux
> 
> ~ # isosize /dev/hdc
> 8164939776
> 
> ~ # cat /proc/ide/hdc/capacity
> 15947148

Looks pretty perfect, maybe it's read-ahead screwing it up. Try if
setting hdparm -a0 /dev/hdc makes a difference.

-- 
Jens Axboe

