Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161199AbWHJMCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161199AbWHJMCL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 08:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161202AbWHJMCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 08:02:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:8669 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161196AbWHJMCJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 08:02:09 -0400
Message-ID: <44DB203A.6050901@garzik.org>
Date: Thu, 10 Aug 2006 08:02:02 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/9] sector_t format string
References: <1155172843.3161.81.camel@localhost.localdomain> <20060809234019.c8a730e3.akpm@osdl.org> <Pine.LNX.4.64.0608101302270.6762@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0608101302270.6762@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Wed, 9 Aug 2006, Andrew Morton wrote:
> 
>> That also being said...  does a 32-bit sector_t make any sense on a
>> 48-bit-blocknumber filesystem?  I'd have thought that we'd just make ext4
>> depend on 64-bit sector_t and be done with it.
> 
> Is this really necessary? There are a few features, which would make ext4 
> also interesting at the low end (e.g. extents). Storing 64bit values on 
> disk is fine, but they should be converted to native values as soon as 
> possible.

Consider what that means.  "converted to native" means dealing with 
truncation issues...

	Jeff



