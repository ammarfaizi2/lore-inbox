Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbVLJJhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbVLJJhv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 04:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVLJJhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 04:37:51 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965118AbVLJJhv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 04:37:51 -0500
Date: Sat, 10 Dec 2005 01:37:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Cornelia Huck <cornelia.huck@gmail.com>
Cc: schwidefsky@de.ibm.com, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 15/17] s390: convert /proc/cio_ignore.
Message-Id: <20051210013730.2f932332.akpm@osdl.org>
In-Reply-To: <a070070d0512100130u592b3517y@mail.gmail.com>
References: <20051209152909.GP6532@skybase.boeblingen.de.ibm.com>
	<20051209235321.2281b7e6.akpm@osdl.org>
	<a070070d0512100130u592b3517y@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cornelia Huck <cornelia.huck@gmail.com> wrote:
>
> > Unneeded (and undesirable) cast of void*.
> 
>  Some people seem to prefer explicit casts to make the
>  type more clear. Is there any concensus on this? (I don't care
>  either way ;))

It's better to omit the casts because

a) they're ugly and 

b) If someone changes the type of the RHS from void* to anything else,
   we'll get a warning, probably leading us to a bug.  The cast would have
   prevented that warning.  IOW, omitting the cast is more type-safe.
