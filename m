Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbTCSAFO>; Tue, 18 Mar 2003 19:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262837AbTCSAFN>; Tue, 18 Mar 2003 19:05:13 -0500
Received: from packet.digeo.com ([12.110.80.53]:11689 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262835AbTCSAFM>;
	Tue, 18 Mar 2003 19:05:12 -0500
Date: Tue, 18 Mar 2003 16:09:55 -0800
From: Andrew Morton <akpm@digeo.com>
To: Andries.Brouwer@cwi.nl
Cc: Andries.Brouwer@cwi.nl, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] dev_t [1/3]
Message-Id: <20030318160955.20afccde.akpm@digeo.com>
In-Reply-To: <UTC200303182353.h2INr3p14431.aeb@smtp.cwi.nl>
References: <UTC200303182353.h2INr3p14431.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 00:15:53.0416 (UTC) FILETIME=[B441BC80:01C2EDAC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
>     From: Jeff Garzik <jgarzik@pobox.com>
> 
>     > So, kill cdev_cachep, cdev_cache_init,
>     > cdfind, cdget, cdput, inode->i_cdev, struct char_device.
>     > All of this is dead code today.
> 
>     You're also removing refcount code... why not fix it up instead?
> 
>     I agree your patch is mostly correct from a "today" standpoint,
>     but from a long term standpoint ...
> 
> Your remarks have been made a few times already, and each
> time I answered that my objective was to give Linux 2.6
> a 32-bit dev_t, and my objective is not to do work that
> is not for 2.6 but for 2.8.
> 

What does that whole hash/cache/refcount setup in there actually do, and why
can we afford to remove it for 2.6?

