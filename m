Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUDTAWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUDTAWt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUDTAWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:22:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:24193 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261763AbUDTAWq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:22:46 -0400
Date: Mon, 19 Apr 2004 17:21:24 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [PATCH 2.6.5] Add class support to drivers/mtd/mtdchar.c
Message-ID: <419620000.1082420484@w-hlinder.beaverton.ibm.com>
In-Reply-To: <1082160598.3083.54.camel@localhost.localdomain>
References: <207270000.1082063407@w-hlinder.beaverton.ibm.com> <1082063698.2949.6.camel@localhost.localdomain> <221630000.1082154920@w-hlinder.beaverton.ibm.com>
 <1082160598.3083.54.camel@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Friday, April 16, 2004 08:09:58 PM -0400 David Woodhouse <dwmw2@infradead.org> wrote:
> 
> MTDRAM is a fake MTD device, using backing store provided by vmalloc().
> There is no hardware. If you have mtdram.ko and mtdchar.ko both loaded,
> you should have been able to access /dev/mtd0 and you should have seen
> it in /proc/mtd

Thanks. I can see /proc/mtd but there is no /dev/mtd0 (or anything mtd in /dev).
And still all I see in sysfs is the mtd class directory no dev file.

Module                  Size  Used by
mtdram                  2884  0
mtdchar                 5000  0
mtdcore                 5760  3 mtdram,mtdchar

I just tried it on a clean 2.6.6-rc1 kernel and the same thing happened. Created
a /proc/mtd but no /dev/mtd*

So either Im doing something wrong or there is a bug of some sort...

Thanks a lot.

Hanna

