Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262256AbSJKAsU>; Thu, 10 Oct 2002 20:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262261AbSJKAsU>; Thu, 10 Oct 2002 20:48:20 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:4338 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262256AbSJKAsS>;
	Thu, 10 Oct 2002 20:48:18 -0400
Message-ID: <3DA62120.9070609@us.ibm.com>
Date: Thu, 10 Oct 2002 17:53:52 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Patrick Mansfield <patmans@us.ibm.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Degraded I/O performance, since 2.5.41
References: <Pine.LNX.4.44.0210092015170.9790-100000@home.transmeta.com> <3DA61041.9080808@us.ibm.com> <20021011004227.GA27073@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> I  try to keep the drivers working
> at a basic level, but until I'm done, benchmarking is pretty much a waste
> of time I think)

Benchmarking is integral in what we're doing right now.  We need to 
make quick decisions about what is good or bad before the freeze. 
This patch makes my machine unusable for anything that isn't in the 
pagecache.  A simple "make oldconfig" on a cold tree takes minutes to 
complete.  My grep test got an order of magnitude worse.  If we have 
to keep this code, can we just make the default queue HUGE for now? 
Will that work around it?

A bunch of the AIO people use QLogic cards, which I'm sure are broken 
by this as well.  I'm going to back this patch out for all the testing 
trees I do, and I suggest anyone who cares about I/O on SCSI 
(excluding aic7xxx) after 2.5.41 do the same.

-- 
Dave Hansen
haveblue@us.ibm.com

