Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSIYGAe>; Wed, 25 Sep 2002 02:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261919AbSIYGAe>; Wed, 25 Sep 2002 02:00:34 -0400
Received: from franka.aracnet.com ([216.99.193.44]:27793 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261907AbSIYGAd>; Wed, 25 Sep 2002 02:00:33 -0400
Date: Tue, 24 Sep 2002 23:03:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38-mm2 dbench $N times
Message-ID: <297318451.1032908628@[10.10.2.3]>
In-Reply-To: <3D9103EB.FC13A744@digeo.com>
References: <3D9103EB.FC13A744@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Not sure. This is boot bay SCSI crud, but single-disk FC looks
>> *worse* for no obvious reason. Multiple disk tests do much better
>> (about matching the el-scruffo PC numbers above).
> 
> dbench 16 on that sort of machine is a memory bandwidth test.
> And a dcache lock exerciser.  It basically doesn't touch the
> disk.  Something very bad is happening.

Does dbench have any sort of CPU locality between who read it 
into pagecache, and who read it out again? If not, you stand
7/8 chance of being on the wrong node, and getting 1/20 of the
mem bandwidth ....

M.

