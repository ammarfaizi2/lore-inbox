Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261890AbSJIRv3>; Wed, 9 Oct 2002 13:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261885AbSJIRv3>; Wed, 9 Oct 2002 13:51:29 -0400
Received: from packet.digeo.com ([12.110.80.53]:44940 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262022AbSJIRuj>;
	Wed, 9 Oct 2002 13:50:39 -0400
Message-ID: <3DA46DBC.51F120A5@digeo.com>
Date: Wed, 09 Oct 2002 10:56:12 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>, Thomas Molina <tmolina@cox.net>
CC: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.41-bk2 yet another $SLEEPING at mm/slab.c:1374 report
References: <1034179026.32404.194.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2002 17:56:15.0255 (UTC) FILETIME=[29523270:01C26FBD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> ...
> Debug: sleeping function called from illegal context at mm/slab.c:1374
> Call Trace:
>  [<c0119c86>] __might_sleep+0x56/0x5d
>  [<c0135f75>] kmalloc+0x65/0x1b0
>  [<c0120478>] __request_region+0x18/0xc0
>  [<c021897f>] eata2x_detect+0x13f/0xd10

Ton of stack gunk there.  This is eata2x_detect() calling
port_detect() under driver_lock.
