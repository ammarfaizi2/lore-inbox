Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbSLBRRX>; Mon, 2 Dec 2002 12:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbSLBRRW>; Mon, 2 Dec 2002 12:17:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54546 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264901AbSLBRRW>;
	Mon, 2 Dec 2002 12:17:22 -0500
Message-ID: <3DEB9761.50503@pobox.com>
Date: Mon, 02 Dec 2002 12:24:49 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@sgi.com>
CC: marcelo@connectiva.com.br.munich.sgi.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
References: <20021202192652.A25938@sgi.com>
In-Reply-To: <20021202192652.A25938@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> now that all commercial vendors ship a backport of Ingo's O(1) scheduler
> external projects like XFS have to track those projects in addition to the
> mainline kernel.
> 
> Having the common new APIs available in mainline would be a very good thing
> for those projects.  We already have a proper yield() in 2.4.20, but the
> set_cpus_allowed() API as used e.g. for kernelthreads bound to CPUs is
> still missing.
> 
> Any chance you could apply Robert Love's patch to add it for 2.4.21?  Note
> that it does not change any existing code but just adds that interface.


Adding to that, it is also used for backporting Ingo's workqueue stuff, 
which is useful and completely separate from the O(1) scheduler.

I plan on using workqueues for moving some drivers' duties to process 
context where it really belongs [which in turn fixes bugs].

	Jeff




