Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132815AbRAQUlA>; Wed, 17 Jan 2001 15:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135527AbRAQUkv>; Wed, 17 Jan 2001 15:40:51 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:44028 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S130643AbRAQUj7>; Wed, 17 Jan 2001 15:39:59 -0500
Date: Wed, 17 Jan 2001 14:39:57 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20010117121719.A29786@skull.piratehaven.org>
In-Reply-To: <20010117135420.A3536@remotepoint.com> <20010117135420.A3536@remotepoint.com> 
	; from rick@remotepoint.com on Wed, Jan 17, 2001 at 01:54:20PM -0600
Subject: Re: kmalloc() of 4MB causes "kernel BUG at slab.c:1542!"
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010117204044Z130643-403+1272@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Brian Pomerantz <bapper@piratehaven.org> on Wed, 17
Jan 2001 12:17:19 -0800


> The most you can kmalloc() is 128KB unless this has changed in the 2.4
> kernel which I doubt.  If you want a region of memory that large, use
> vmalloc().  Of course, this doesn't guarantee a contiguous region.

Couldn't you also use get_free_pages (commonly abbreviated as "gfp")?  You can
alloc up to 2MB chunks on an x86 I think.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
