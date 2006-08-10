Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161161AbWHJSvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWHJSvl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 14:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161158AbWHJSvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 14:51:41 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36038 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161155AbWHJSvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 14:51:40 -0400
Message-ID: <44DB8036.5020706@us.ibm.com>
Date: Thu, 10 Aug 2006 11:51:34 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: cmm@us.ibm.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
References: <1155172622.3161.73.camel@localhost.localdomain> <20060809233914.35ab8792.akpm@osdl.org>
In-Reply-To: <20060809233914.35ab8792.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Also, JBD is presently feeding into submit_bh() buffer_heads which span two
> machine pages, and some device drivers spit the dummy.  It'd be better to
> fix that once, rather than twice..  
>   
Andrew,

I looked at this few days ago. I am not sure how we end up having 
multiple pages (especially,
why we end up having buffers with bh_size > pagesize) ? Do you know why ?

Easiest fix would be to fix submit_bh() to deal with multiple vecs - 
which is vetoed by
Jens and I agree with him :(

Thanks,
Badari

