Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTD1QlP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbTD1QlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:41:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:15599 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261193AbTD1QlM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:41:12 -0400
Message-ID: <3EAD5C44.103@us.ibm.com>
Date: Mon, 28 Apr 2003 09:52:20 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD44BF.30808@gmx.net> <20030428151648.GF4525@Wotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>and 64GB is available from vendors who are willing to apply the pgcl
>>patch.
> 
> Nobody is doing that. pgcl is 2.5 only and seems to be still quite instable.
> Also it's extremly intrusive.

Bill will probably wake up any time now and chime in, but don't forget
all of the drivers.

# grep -r PAGE_SIZE drivers/ | wc -l
893

Each one of those needs to be audited before pgcl is acceptable to a
wide audience.  We've already seen plenty of stuff that breaks.  ext2/3
look to be all right, but I know that JFS is broken.
-- 
Dave Hansen
haveblue@us.ibm.com

