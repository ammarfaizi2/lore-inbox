Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSGHVks>; Mon, 8 Jul 2002 17:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317170AbSGHVkr>; Mon, 8 Jul 2002 17:40:47 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:38099 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317169AbSGHVkr> convert rfc822-to-8bit; Mon, 8 Jul 2002 17:40:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: pmenage@ensim.com (pmenage@ensim.com)
Subject: Re: BKL removal
Date: Mon, 8 Jul 2002 23:45:03 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <E17RdkT-0007Qt-00@pmenage-dt.ensim.com>
In-Reply-To: <E17RdkT-0007Qt-00@pmenage-dt.ensim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207082345.03027.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 8. Juli 2002 21:00 schrieb pmenage@ensim.com:
> In article <0C01A29FBAE24448A792F5C68F5EA47D2B0C8A@nasdaq.ms.ensim.com>,
>
> you write:
> >The BKL, unless used unbalanced, can never cause a bug.
> >It could be insufficient or superfluous, but never be really buggy in
> >itself.
>
> Unless you're including incorrect nesting in your definition of
> "unbalanced", that's not really true. E.g. lock_kernel() anywhere that
> dcache_lock is held can deadlock against anywhere that does a path
> lookup with the BKL held (such as do_coredump()).

Yes, for the record. If you mix locking orders you can deadlock, as with any
other lock. And the BKL needs process context. And it doesn't help
against races with interrupts.

	Regards
		Oliver

