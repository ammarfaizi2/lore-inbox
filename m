Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbSLNSex>; Sat, 14 Dec 2002 13:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265797AbSLNSex>; Sat, 14 Dec 2002 13:34:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:42682 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265786AbSLNSew>;
	Sat, 14 Dec 2002 13:34:52 -0500
Message-ID: <3DFB7B9E.FC404B6B@digeo.com>
Date: Sat, 14 Dec 2002 10:42:38 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: Hans Reiser <reiser@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK][PATCH] ReiserFS CPU and memory bandwidth efficient large writes
References: <3DFA2D4F.3010301@namesys.com> <3DFA53DA.DE6788C1@digeo.com> <20021214162108.A3452@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2002 18:42:38.0725 (UTC) FILETIME=[93A98350:01C2A3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> 
> Hello!
> 
> On Fri, Dec 13, 2002 at 01:40:42PM -0800, Andrew Morton wrote:
> 
> > This seems wrong.  This could be a newly-allocated pagecache page.  It is not
> > yet fully uptodate.  If (say) the subsequent copy_from_user gets a fault then
> > it appears that this now-uptodate pagecache page will leak uninitialised stuff?
> 
> Ok, after all I think we do not need this uptodate stuff at all.

Well that certainly simplifies things.
 
> Find below the patch that address all the issues you've brought.
> It is on top of previous one.
> Do you think it is ok now?

I addresses the things I noticed and raised, thanks.  Except for the
stack-space use.  People are waving around 4k-stack patches, and we
do need to be careful there.
