Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267396AbSLRV6z>; Wed, 18 Dec 2002 16:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267381AbSLRV6W>; Wed, 18 Dec 2002 16:58:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:60611 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267379AbSLRV5U>;
	Wed, 18 Dec 2002 16:57:20 -0500
Message-ID: <3E00F11A.CC33F9DC@digeo.com>
Date: Wed, 18 Dec 2002 14:05:14 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Macaulay <robert_macaulay@dell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.47 - Assertion failed in fs/jbd/journal.c:415
References: <3E00DC07.7729E6A2@digeo.com> <Pine.LNX.4.44.0212181453001.16565-100000@ping.us.dell.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2002 22:05:14.0662 (UTC) FILETIME=[8AD14C60:01C2A6E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Macaulay wrote:
> 
> On Wed, 18 Dec 2002, Andrew Morton wrote:
> > I can't immediately see what would cause this.  There is code in
> > __journal_file_buffer which could have triggered this, but we should
> > have exclusion from that via both lock_kernel() and lock_journal().
> >
> > I'll see if Stephen can spot it.   I shall assume you were using
> > the data-ordered journalling mode.
> >
> Correct, I also had them mounted with noatime as well if that matters.

Seems that I failed to propagate one of Stephen's 2.4 fixes forwards.
It could well explain this failure.  I shall send you the diff after
testing.
