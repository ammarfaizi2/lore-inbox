Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTHSVWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbTHSVVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:21:44 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:27096 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261336AbTHSVSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:18:06 -0400
Subject: Re: redhat 2.4.20 kernel 3.5G patch, bug report on my previous
	2.4.18 kernel 3.5G patch
From: Dave Hansen <haveblue@us.ibm.com>
To: Chuck Luciano <chuck@mrluciano.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <NFBBKNADOLMJPCENHEALCENAGLAA.chuck@mrluciano.com>
References: <NFBBKNADOLMJPCENHEALCENAGLAA.chuck@mrluciano.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061327818.25944.48.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 19 Aug 2003 14:16:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 10:55, Chuck Luciano wrote:
> Again, I've been kinda lazy about adding the configuration stuff,
> but, this patch applied to kernel-2.4.20-18.7.src.rpm will give
> you a kernel where PAGE_OFFSET can be set with 2 MB granularity
> instead of 1GB.

This sounds familar from somewhere.  A little attribution to the source
of the code would be nice. :) 

> BTW, there is a defect in the 2.4.18 version of this patch in the
> function get_pgd_slow which doesn't handle the partial PGD
> properly. In 2.4.20 the fix for this problem is in the function 
> pgd_alloc. I will probably not have time to back port this fix to
> 2.4.18.

Actually, I would just do what we did in 2.5 and throw away *_pgd_fast()
functions and just use a slab constructor and destructor to handle it
for you.

> Anyway, for your fun and amusement, the 2.4.20 patch is working 
> and ready for use. I haven't tried seeing just how far I can push
> PAGE_OFFSET yet, but I'd like to see how close I can get to 
> 0xf0000000 and maybe beyond.

I know I've done at least 0xf8000000 on 2.5.  

-- 
Dave Hansen
haveblue@us.ibm.com

