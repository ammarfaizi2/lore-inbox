Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWHJUOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWHJUOf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWHJUOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:42627 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750922AbWHJUNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:13:37 -0400
Message-ID: <44DB936D.2080909@garzik.org>
Date: Thu, 10 Aug 2006 16:13:33 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
References: <1155172622.3161.73.camel@localhost.localdomain> <20060809233914.35ab8792.akpm@osdl.org> <44DB8036.5020706@us.ibm.com>
In-Reply-To: <44DB8036.5020706@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> Andrew Morton wrote:
>> Also, JBD is presently feeding into submit_bh() buffer_heads which 
>> span two
>> machine pages, and some device drivers spit the dummy.  It'd be better to
>> fix that once, rather than twice..    
> Andrew,
> 
> I looked at this few days ago. I am not sure how we end up having 
> multiple pages (especially,
> why we end up having buffers with bh_size > pagesize) ? Do you know why ?
> 
> Easiest fix would be to fix submit_bh() to deal with multiple vecs - 
> which is vetoed by
> Jens and I agree with him :(

Yep.  The sooner we kill buffer heads and use submit_bio(), the better :)

	Jeff



