Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261851AbSIYA0c>; Tue, 24 Sep 2002 20:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261856AbSIYA0c>; Tue, 24 Sep 2002 20:26:32 -0400
Received: from packet.digeo.com ([12.110.80.53]:10935 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261851AbSIYA0b>;
	Tue, 24 Sep 2002 20:26:31 -0400
Message-ID: <3D9103EB.FC13A744@digeo.com>
Date: Tue, 24 Sep 2002 17:31:39 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm2 dbench $N times
References: <20020924132031.GJ6070@holomorphy.com> <3D90A532.4B95C06B@digeo.com> <20020925001826.GM6070@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Sep 2002 00:31:40.0213 (UTC) FILETIME=[EA4D3E50:01C2642A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> William Lee Irwin III wrote:
> >> Taken on 32x/32G NUMA-Q:
> >> Throughput 67.3949 MB/sec (NB=84.2436 MB/sec  673.949 MBit/sec)  16 procs
> >> dbench 16  11.72s user 122.21s system 422% cpu 31.733 total
> 
> On Tue, Sep 24, 2002 at 10:47:30AM -0700, Andrew Morton wrote:
> > Taken on 2x/0.8G el-scruffo PC:
> > Throughput 135.02 MB/sec (NB=168.775 MB/sec  1350.2 MBit/sec)
> > ./dbench 16  12.11s user 16.29s system 181% cpu 15.646 total
> > What's up with that?
> 
> Not sure. This is boot bay SCSI crud, but single-disk FC looks
> *worse* for no obvious reason. Multiple disk tests do much better
> (about matching the el-scruffo PC numbers above).
> 

dbench 16 on that sort of machine is a memory bandwidth test.
And a dcache lock exerciser.  It basically doesn't touch the
disk.  Something very bad is happening.

Anton can get 3000 MByte/sec ;)
