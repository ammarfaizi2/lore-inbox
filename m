Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269490AbTCDShT>; Tue, 4 Mar 2003 13:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269493AbTCDShS>; Tue, 4 Mar 2003 13:37:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:29852 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S269490AbTCDShS>;
	Tue, 4 Mar 2003 13:37:18 -0500
Date: Tue, 4 Mar 2003 10:48:11 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops Re: 2.5.63-mm2
Message-Id: <20030304104811.6385c69c.akpm@digeo.com>
In-Reply-To: <200303042320.50458.kernel@kolivas.org>
References: <200303042320.50458.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Mar 2003 18:47:40.0455 (UTC) FILETIME=[888DDB70:01C2E27E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> oops running contest:
> 
> Unable to handle kernel paging request at virtual address 9acfdcf2

You had an ext3 handle which has a trashed ->journal pointer.  I've seen that
once, possibly twice before too.

I don't know what is causing it.  It is just kmalloc'ed memory.  It could be
anywhere in the kernel :(  Seems to have started around 2.5.63.


