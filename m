Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266903AbUGMVvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266903AbUGMVvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUGMVvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:51:10 -0400
Received: from web51106.mail.yahoo.com ([206.190.38.148]:55455 "HELO
	web51106.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266902AbUGMVuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:50:50 -0400
Message-ID: <20040713215046.39251.qmail@web51106.mail.yahoo.com>
Date: Wed, 14 Jul 2004 07:50:46 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: Re: 2.4.27-rc3 __alloc_pages: 3-order allocation failed (gfp=0x20/0)
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040713191445.GB9655@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for the reply.

> The "3-order allocation failures" should not be a
> problem - its just 
> the ide-scsi driver trying to allocate a big
> scatter-gather list of 8 pages,
> it fails then tries to allocate "smaller pieces" (4
> pages then if that fails 
> 1 page of memory). 
> 
> Now the problem is the ide-scsi timeout's -- I
> really have not much of 
> an idea what could be going wrong there.
> 
>  
I just found that if using cdda2wav but use it
cooked_ctl interface (not the scsi one so I dont use
ide-scsi any more) it works ; still until the last
audio track it still report some error and hang , need
to do Ctrl+C to stop it. However the last sound track
is normal when play it. Use cdparanoia for both
(ide-scsi or ide-cd) it works as normal.

I suspect bug in cdda2wav, or ide-scsi combination
when readding cd text and info (I think cdparanoia
does not read cd text). it may even be that my audio
disc has some damage.
I will test with other audio cd today to see what
happened.

Regards,


=====
S.KIEU

Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
