Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135599AbRD1THU>; Sat, 28 Apr 2001 15:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135598AbRD1THK>; Sat, 28 Apr 2001 15:07:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:60408 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135597AbRD1TG5>;
	Sat, 28 Apr 2001 15:06:57 -0400
Date: Sat, 28 Apr 2001 15:06:55 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mark Hemment <markhe@veritas.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel lock in dcache.c
In-Reply-To: <Pine.LNX.4.21.0104281909320.703-100000@alloc.wat.veritas.com>
Message-ID: <Pine.GSO.4.21.0104281506150.23909-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 28 Apr 2001, Mark Hemment wrote:

> Hi,
> 
>   d_move() in fs/dcache.c is checking the kernel lock is held
> (switch_names() does the same, but is only called from d_move()).
> 
>   My question is why?
>   I can't see what it is using the kernel lock to sync/protect against.

Metric buttload of users of ->d_parent in the filesystems.

