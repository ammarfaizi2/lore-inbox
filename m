Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbTAOS3m>; Wed, 15 Jan 2003 13:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbTAOS3m>; Wed, 15 Jan 2003 13:29:42 -0500
Received: from franka.aracnet.com ([216.99.193.44]:54734 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266438AbTAOS3l>; Wed, 15 Jan 2003 13:29:41 -0500
Date: Wed, 15 Jan 2003 10:37:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] (0/7) Finish moving NUMA-Q into subarch, cleanup
Message-ID: <949530000.1042655849@titus>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E233@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E233@fmsmsx405.fm.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can these (MAX_IO_APICS, MAX_APICS) be moved to sub-arch too, instead of

Not easily, at least not without creating a circular dependency problem.
Try it ;-)

I guess we chould create another subarch header file just for these if we 
really have to, but that seem like overkill.

If you can come up with a clean patch (check it compiles on uniproc with
and without IO/APIC turned on, and standard SMP as well), I'd really 
be interested to see it ... would be most helpful

> replacing CONFIG NUMA by CONFIG NUMAQ?

Actually replacing CONFIG_X86_NUMA with CONFIG_NUMA ... and we could
do (CONFIG_NUMA || CONFIG_BIGSMP) instead. But you're right, subarch
would be much better if you can find a way.

M.

