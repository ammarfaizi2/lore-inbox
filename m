Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263877AbTEOGHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTEOGHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:07:47 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:9430 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263877AbTEOGHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:07:46 -0400
Date: Wed, 14 May 2003 23:21:59 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: vaxerdec@frontiernet.net, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT write to file by block-aligned, block-multiple buf
 fails?
Message-Id: <20030514232159.655b4908.akpm@digeo.com>
In-Reply-To: <20030515000417.D10503@schatzie.adilger.int>
References: <20030515013350.B1540@newbox.localdomain>
	<20030515000417.D10503@schatzie.adilger.int>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 May 2003 06:20:31.0010 (UTC) FILETIME=[15DD6820:01C31AAA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> wrote:
>
> On May 15, 2003  01:33 -0400, Scott McDermott wrote:
> > This should mean I can write aligned pages with direct IO, right?
> > 
> >         write: Invalid argument
> > 
> >         $ grep /tmp /proc/mounts
> >         /dev/hda5 /mnt/tmp ext3 rw 0 0
> 
> ext3 does not support O_DIRECT in 2.4 yet.
> 

It does if you apply

ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc2aa1/10_ext3-o_direct-2
