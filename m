Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262881AbSKMWr6>; Wed, 13 Nov 2002 17:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262924AbSKMWr5>; Wed, 13 Nov 2002 17:47:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:49345 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262881AbSKMWr4>;
	Wed, 13 Nov 2002 17:47:56 -0500
Message-ID: <3DD2D830.5914E698@digeo.com>
Date: Wed, 13 Nov 2002 14:54:40 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.5.47-mm2
References: <20021113211539.21064.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Nov 2002 22:54:41.0038 (UTC) FILETIME=[A6751AE0:01C28B67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> Hi Andrew,
> I can reproduce an oops simply running fillmem 400
> 
> kernel is 2.5.47-mm2
> fs is ext3.
> 
> ..
> >>EIP; c012e137 <get_fs_type+7/30>   <=====

Sorry, don't know.  It doesn't happen here.  It looks like the
filesystem registration code was affected by the recent modules improvement.

If you can reproduce it, could you please test 2.5.47 plus 
just the -bk changes?  They are in
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.47/2.5.47-mm2/broken-out/linus.patch
