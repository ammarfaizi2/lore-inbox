Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262212AbSIZHvs>; Thu, 26 Sep 2002 03:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262231AbSIZHvs>; Thu, 26 Sep 2002 03:51:48 -0400
Received: from [203.117.131.12] ([203.117.131.12]:50123 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262212AbSIZHvr>; Thu, 26 Sep 2002 03:51:47 -0400
Message-ID: <3D92BDC8.8080603@metaparadigm.com>
Date: Thu, 26 Sep 2002 15:56:56 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.19pre10aa4 OOPS in ext3 (get_hash_table,  unmap_underlying_metadata)
References: <3D92A1D0.5000203@metaparadigm.com> <3D92B6F3.1428A76A@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/02 15:27, Andrew Morton wrote:
> Michael Clark wrote:
> 
>>Hiya,
>>
>>Been having frequent (every 4-8 days) oopses with 2.4.19pre10aa4 on
>>a moderately loaded server (100 users - 0.4 load avg).
>>
>>The server is a Intel STL2 with dual P3, 1GB RAM, Intel Pro1000T
>>and Qlogic 2300 Fibre channel HBA.
>>
>>We are running qla2300, e1000 and lvm modules unmodified as present in
>>2.4.19pre10aa4. We also have quotas enabled on 1 of the ext3 fs.
>>
> 
> 
> It's not familiar, sorry.

Maybe I should try XFS? I've heard of people running this for
80+ days and no downtime. I really would like to get past 8 days.

> People are saying unkind things about the qlogic driver, and

Yes i know. My experience seems to be bad fault recovery after
a LIP reset although the driver in 2.4.19pre10aa4 seems okay
(have tested loop interruption under IO heavy load).

> the new version in Andrea's latest patchset is definitely
> faster than before.   Might be worth a shot.

So, is possible for qlogic driver to be doing naughty things
with bufferheads? or is it more likely in the fs?

Anyone out there running a reasonably busy fileserver with
qlogic FC HBA and using ext3 or XFS with quotas? What
kernel/qlogic driver combo?

~mc

