Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133117AbRDZGW3>; Thu, 26 Apr 2001 02:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133120AbRDZGWS>; Thu, 26 Apr 2001 02:22:18 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:32263 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S133117AbRDZGWL>; Thu, 26 Apr 2001 02:22:11 -0400
Date: Thu, 26 Apr 2001 00:15:39 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Feng Xian <fxian@fxian.jukie.net>
Cc: linux-kernel@vger.kernel.org, Feng Xian <fxian@chrysalis-its.com>
Subject: Re: __alloc_pages: 4-order allocation failed
Message-ID: <20010426001539.A14115@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.4.30.0104252059430.5253-100000@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0104252059430.5253-100000@tiger>; from fxian@fxian.jukie.net on Wed, Apr 25, 2001 at 09:09:57PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I am seeing this as well on 2.4.3 with both _get_free_pages() and 
kmalloc().  In the kmalloc case, the modules hang waiting
for memory.

Jeff

On Wed, Apr 25, 2001 at 09:09:57PM -0400, Feng Xian wrote:
> Hi,
> 
> I am running linux-2.4.3 on a Dell dual PIII machine with 128M memory.
> After the machine runs a while, dmesg shows,
> 
> __alloc_pages: 4-order allocation failed.
> __alloc_pages: 3-order allocation failed.
> __alloc_pages: 4-order allocation failed.
> __alloc_pages: 4-order allocation failed.
> __alloc_pages: 4-order allocation failed.
> __alloc_pages: 4-order allocation failed.
> 
> 
> and sometime the system will crash. I looked into the memory info,
> there still has some free physical memory (20M) left and swap space is
> almost not in use. (250M swap)
> 
> I didn't have this problem when I ran 2.4.0 (I even didn't see it on
> 2.4.2) could anybody tell me what's wrong or where should I look into this
> problem?
> 
> Thanks,
> 
> Alex
> 
> -- 
> Feng Xian
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
