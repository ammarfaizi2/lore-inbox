Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSJUVHb>; Mon, 21 Oct 2002 17:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJUVHb>; Mon, 21 Oct 2002 17:07:31 -0400
Received: from packet.digeo.com ([12.110.80.53]:50328 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261624AbSJUVHa>;
	Mon, 21 Oct 2002 17:07:30 -0400
Message-ID: <3DB46DFA.DFEB2907@digeo.com>
Date: Mon, 21 Oct 2002 14:13:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
References: <302190000.1035232837@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 21:13:31.0063 (UTC) FILETIME=[B4F82C70:01C27946]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> My big NUMA box went OOM over the weekend and started killing things
> for no good reason (2.5.43-mm2). Probably running some background
> updatedb for locate thing, not doing any real work.
> 
> meminfo:
> 

Looks like a plain dentry leak to me.  Very weird.

Did the machine recover and run normally?

Was it possible to force the dcache to shrink? (a cat /dev/hda1
would do that nicely)

Is it reproducible?
