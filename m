Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSGIMvf>; Tue, 9 Jul 2002 08:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSGIMve>; Tue, 9 Jul 2002 08:51:34 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:45005 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315179AbSGIMvb>;
	Tue, 9 Jul 2002 08:51:31 -0400
Date: Tue, 9 Jul 2002 14:54:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Tobias Rittweiler <inkognito.anonym@uni.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] 2.4 IDE core for 2.5
Message-ID: <20020709125412.GB1940@suse.de>
References: <20020709102249.GA20870@suse.de> <01742490.20020709144349@uni.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01742490.20020709144349@uni.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09 2002, Tobias Rittweiler wrote:
> Hello Jens,
> 
> Tuesday, July 9, 2002, 12:22:49 PM, you wrote:
> 
> JA> *.kernel.org://pub/linux/kernel/people/axboe/patches/v2.5/2.5.25/
> 
> After downloading each of the 7 .gz-patches, applying them without any
> complains, I started to compile the new bzImage, but I got an error
> in relation to the FAT support. By switching this support off
> everything'll compile without any further problem though, and I can
> boot from this image even.. :-)

Try doing something ala

#ifdef CONFIG_IDE_25
#include <linux/ide.h>  /* IDE xlate */
#else
#include <linux/ide24.h>
#endif

instead of including ide.h directly in fs/partitions/msdos.c

Yeah it's ugly, but it should fix it for now.

-- 
Jens Axboe

