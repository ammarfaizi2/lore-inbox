Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTDQMLj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 08:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbTDQMLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 08:11:39 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:32269 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261309AbTDQMLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 08:11:38 -0400
Date: Thu, 17 Apr 2003 14:23:28 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Ludovic Drolez <ludovic.drolez@freealter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl to get partitions infos
Message-ID: <20030417122328.GA19035@win.tue.nl>
References: <3E9E7B7C.9090605@freealter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9E7B7C.9090605@freealter.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 12:01:32PM +0200, Ludovic Drolez wrote:

> As I need more than 'cat /proc/partitions', I wondered if there's an 
> ioctl in 2.4 or 2.5 which will kindly return me all the information the 
> kernel knows about partition (start sector, length, type) ? (pls, don't 
> say that I need the parse the partition table myself ;-( )

There are ioctls that will tell you start sector and length.
HDIO_GETGEO gives you start
BLKGETSIZE gives you length

I do not know what you mean by type, but the kernel doesn't know it.

(A partition may be found from a DOS-type or BSD-type or Amiga-type
or ... partition table. Each has its own ways of indicating a type
of partition. A partition can also be created by ioctl where no
partition table is involved. Then there is no type at all.
No type is used by the kernel, roughly speaking.)

Andries

