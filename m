Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291840AbSBAQeE>; Fri, 1 Feb 2002 11:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291836AbSBAQdz>; Fri, 1 Feb 2002 11:33:55 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:50420 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S291835AbSBAQdm>; Fri, 1 Feb 2002 11:33:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Keys <akeys@post.cis.smu.edu>
To: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] kthread abstraction
Date: Fri, 1 Feb 2002 10:32:59 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020201163818.A32551@caldera.de>
In-Reply-To: <20020201163818.A32551@caldera.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020201163337.DHBU26243.rwcrmhc51.attbi.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 01, 2002 09:38, Christoph Hellwig wrote:
> Currently the startup of custom kernel threads contains lots
> of duplicated code (and bugs!).

Very interesting and approachable patch.  Am I correct this replaces the API 
for starting threads like bdflush and kswapd?  Is this just an API 
cleanliness thing or is there a performance motivation?

Just one question....

>
> I'd like to propose the following interface to get rid of these
> code waste:
>
>     int kthread_start(struct kthread *kth)
>
> 	Startup a new kernel thread as described by 'kth' (details
> 	below).  Wait until it has finished initialization.
>
>
>     void kthread_stop(struct kthread *kth)

Do you think you could get by just passing struct task_struct here?  I 
realize that would make it less pleasant for calling functions.  However, it 
would also prevent you from changing something else in the kthread in a later 
version and catching a caller by surprise.

Otherwise, looks nice to my naive eyes :)

-- 
akk~
