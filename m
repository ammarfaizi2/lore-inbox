Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSL2WR5>; Sun, 29 Dec 2002 17:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSL2WR5>; Sun, 29 Dec 2002 17:17:57 -0500
Received: from packet.digeo.com ([12.110.80.53]:37622 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261829AbSL2WR4>;
	Sun, 29 Dec 2002 17:17:56 -0500
Message-ID: <3E0F7684.6D07D4FB@digeo.com>
Date: Sun, 29 Dec 2002 14:26:12 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more deprectation bits
References: <20021229215554.A11360@lst.de> <3E0F6B6B.2FCEC917@digeo.com> <20021229224713.A12011@lst.de> <3E0F6F64.DDE742A3@digeo.com> <20021229225843.A12122@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Dec 2002 22:26:12.0388 (UTC) FILETIME=[4B064E40:01C2AF89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Sun, Dec 29, 2002 at 01:55:48PM -0800, Andrew Morton wrote:
> > > Even if it's safe in that particular case, most code in the kernel runs
> > > without BKL.  This patch just makes the deprication of sleep_on
> > > explicit.
> >
> > This would be more appropriate:
> 
> I don't think so.  As you said before sleep_on is perfectly fine for
> the small part of code still covered by BKL, so we should not impose
> any runtime overhead (i.e. warnings) but rather remind at compile time.
> 
> That's what's so nice with the gcc extension (and you won't see it
> anyway as long as you stay at egcs 1.1 :))

Others will.  It will result in developers being distracted into "fixing"
non-bugs.  It will introduce risk and it will delay the release of the
2.6 kernel.

Please concentrate on things which *matter*.  Focus on getting this piece
of software into a deliverable state and do not be distracted into futzing
about with stuff which clearly was not addressed at the appropriate time.
