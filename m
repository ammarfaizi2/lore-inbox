Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263136AbTCSUIU>; Wed, 19 Mar 2003 15:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263138AbTCSUIU>; Wed, 19 Mar 2003 15:08:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:7878 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263136AbTCSUIU>;
	Wed, 19 Mar 2003 15:08:20 -0500
Date: Wed, 19 Mar 2003 12:19:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: philippe.gramoulle@mmania.com, linux-kernel@vger.kernel.org
Subject: Re: Hard freeze with 2.5.65-mm1
Message-Id: <20030319121909.74f957af.akpm@digeo.com>
In-Reply-To: <877kav5ikv.fsf@lapper.ihatent.com>
References: <20030319104927.77b9ccf9.philippe.gramoulle@mmania.com>
	<8765qfacaz.fsf@lapper.ihatent.com>
	<20030319182442.4a9fa86c.philippe.gramoulle@mmania.com>
	<877kav5ikv.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 20:19:06.0462 (UTC) FILETIME=[CAAA57E0:01C2EE54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> I've had I/O stall a few times while watching movies, but only the
> mplayer process hung, and I could break it off and restart and it
> woudl fun again for a few minutes.

This is a bug in the new nanosleep code.  mplayer asks the kernel for a 50
millisecond sleep and the kernel gives it a two month sleep instead.

Please set INITIAL_JIFFIES to zero and retest.

With what compiler are you building your kernels?
