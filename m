Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261396AbTCOFdI>; Sat, 15 Mar 2003 00:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261397AbTCOFdI>; Sat, 15 Mar 2003 00:33:08 -0500
Received: from franka.aracnet.com ([216.99.193.44]:53135 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261396AbTCOFdH>; Sat, 15 Mar 2003 00:33:07 -0500
Date: Fri, 14 Mar 2003 21:43:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>
cc: bzzz@tmi.comex.ru, adilger@clusterfs.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] concurrent block allocation for ext2 against 2.5.64
Message-ID: <2650000.1047707016@[10.10.2.4]>
In-Reply-To: <20030315053053.GM20188@holomorphy.com>
References: <m3el5bmyrf.fsf@lexa.home.net> <20030313015840.1df1593c.akpm@digeo.com> <m3of4fgjob.fsf@lexa.home.net> <20030313165641.H12806@schatzie.adilger.int> <m38yvixvlz.fsf@lexa.home.net> <20030315043744.GM1399@holomorphy.com> <20030314205455.49f834c2.akpm@digeo.com> <20030315053053.GM20188@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On the quad Xeon (after increasing dirty_ratio and dirty_background_ratio so
>> I/O was negligible) I was able to measure a 1.5% improvement.
>> I worry about the hardware you're using there.
> 
> Why? The adapter is "vaguely modern" (actually acquired as part of a
> hunt for an HBA w/a less buggy driver) but the box and disks and so on
> are still pretty ancient, so the absolute numbers aren't useful.
> 
> To get a real comparison we'd have to compare spindles, HBA's, and
> cpus, and attempt to factor them out. The disks are actually only
> capable of doing 30MB/s or 40MB/s, the buses can only do 40MB/s, and
> the cpus are 700MHz P-III's. Where dbench gets its numbers faster than
> wirespeed I have no idea...

You'd also have to stop sending all your IO over a NUMA backplane ...

> This locking issue may just need more cpus to bring out.

More than 32 CPUs? Hmmmm.

M.
