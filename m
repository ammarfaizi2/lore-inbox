Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSLOS07>; Sun, 15 Dec 2002 13:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbSLOS06>; Sun, 15 Dec 2002 13:26:58 -0500
Received: from packet.digeo.com ([12.110.80.53]:17095 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262317AbSLOS06>;
	Sun, 15 Dec 2002 13:26:58 -0500
Message-ID: <3DFCCB1D.53D841B@digeo.com>
Date: Sun, 15 Dec 2002 10:34:05 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Octave <oles@ovh.net>
CC: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: problem with Andrew's patch ext3
References: <20021215144050.GY12395@ovh.net> <3DFCC815.3C0010F2@digeo.com> <20021215182645.GS23211@ovh.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2002 18:34:46.0603 (UTC) FILETIME=[A4AB29B0:01C2A468]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Octave wrote:
> 
> On Sun, Dec 15, 2002 at 10:21:09AM -0800, Andrew Morton wrote:
> > Octave wrote:
> > >
> > > Hello Andrew,
> > >
> > > I patched 2.4.20 with your patch found out on http://lwn.net/Articles/17447/
> > > and I have a big problem with:
> > > once server is booted on 2.4.20 with your patch, when I want to reboot
> > > with /sbin/reboot, server makes a Segmentation fault and it crashs.
> >
> > It works OK here.  Could you please check that the kernel was fully
> > rebuilt?  Do a `make clean'?  If the kernel was not fully rebuilt
> > then things will go wrong because a structure size was changed.
> 
> yes, since I took a new tar.gz
> made dep && make clean && make bzImage
> I did it 5 times (for differents servers).
> 

So is any additional information available?  What was on the
console?  If it was a kernel crash, a ksymoops trace would be
valuable.

The patch is at
http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.20/sync_fs.patch
could you ensure that it was applied successfully?
