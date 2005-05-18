Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262235AbVEROjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbVEROjv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVEROje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:39:34 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:57840 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262235AbVEROiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 10:38:52 -0400
Message-ID: <428B536E.6030700@freenet.de>
Date: Wed, 18 May 2005 16:38:38 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 4/5] loop: execute in place (V2)
References: <1116422644.2202.1.camel@cotte.boeblingen.de.ibm.com> <1116424432.2202.19.camel@cotte.boeblingen.de.ibm.com> <20050518142849.GC23162@infradead.org>
In-Reply-To: <20050518142849.GC23162@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

>On Wed, May 18, 2005 at 03:53:52PM +0200, Carsten Otte wrote:
>  
>
>>[RFC/PATCH 4/5] loop: execute in place (V2)
>>
>>    
>>
>
>This should be ifdef'ed to avoid bloat for non-XIP builds.  Or just be dropped
>completely.  How much difference does it make over read/write and where does
>loop performance matter?
>  
>
I don't think loop on xip is performance critical. For page cache lookup
I see a performance difference of factor 2 on our platform because we
have decent memory bandwidth and lock contention slows things down
with many CPUs. Given that even without this patch we don't do page
cache lookups, I don't think there's much difference. Initially this patch
was written for the old loop driver that won't work without this patch...
Guess that dropping it is a good idea.

