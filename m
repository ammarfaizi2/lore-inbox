Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbTD1Qqg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbTD1Qqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:46:36 -0400
Received: from franka.aracnet.com ([216.99.193.44]:36821 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261202AbTD1Qqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:46:34 -0400
Date: Mon, 28 Apr 2003 09:58:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>
cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <483810000.1051549109@[10.10.2.4]>
In-Reply-To: <3EAD5C44.103@us.ibm.com>
References: <20030424200524.5030a86b.bain@tcsn.co.za>
 <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de>
 <3EAD44BF.30808@gmx.net> <20030428151648.GF4525@Wotan.suse.de>
 <3EAD5C44.103@us.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> and 64GB is available from vendors who are willing to apply the pgcl
>>> patch.
>> 
>> Nobody is doing that. pgcl is 2.5 only and seems to be still quite
>> instable. Also it's extremly intrusive.
> 
> Bill will probably wake up any time now and chime in, but don't forget
> all of the drivers.
> 
># grep -r PAGE_SIZE drivers/ | wc -l
> 893
> 
> Each one of those needs to be audited before pgcl is acceptable to a
> wide audience.  We've already seen plenty of stuff that breaks.  ext2/3
> look to be all right, but I know that JFS is broken.

Well, the upside is that he's only doing s/PAGE_SIZE/MMU_PAGESIZE/
in most places, which are normally both 4K. So it will have no effect
whatsoever unless you explicitly turn it on.

M.

