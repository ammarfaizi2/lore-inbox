Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265573AbSKAB3D>; Thu, 31 Oct 2002 20:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265567AbSKAB2V>; Thu, 31 Oct 2002 20:28:21 -0500
Received: from packet.digeo.com ([12.110.80.53]:35836 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265559AbSKAB0p>;
	Thu, 31 Oct 2002 20:26:45 -0500
Message-ID: <3DC1D9D0.684326AC@digeo.com>
Date: Thu, 31 Oct 2002 17:33:04 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Oleg Drokin <green@namesys.com>, zam@namesys.com,
       umka <umka@thebsh.namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
References: <3DC19F61.5040007@namesys.com> <200210312334.18146.Dieter.Nuetzel@hamburg.de> <3DC1B2FA.8010809@namesys.com> <3DC1D63A.CCAD78EF@digeo.com> <3DC1D885.6030902@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Nov 2002 01:33:05.0052 (UTC) FILETIME=[9FEBCDC0:01C28146]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> 
> Well, if we are only 2.5 times as fast for writes as ext3 after your
> patch is applied, I'll still feel good.;-)
> 

whupping ext3's butt on write performance isn't very hard, really ;)

But it should be done based on "feature equivalency".  By default,
ext3 uses ordered data writes.  Data is written to disk before
the metadata to which that data refers is committed to journal.

It would be questionable to compare a metadata-only journalling
approach to ext3 with data=journal or data=ordered.
