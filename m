Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbTAAUl0>; Wed, 1 Jan 2003 15:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTAAUl0>; Wed, 1 Jan 2003 15:41:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62854
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265066AbTAAUl0>; Wed, 1 Jan 2003 15:41:26 -0500
Subject: Re: sd driver NOT_READY behavior / was Re: How does the disk buffer
	cache work?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Zahorik <matt@albany.net>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.BSF.4.43.0301011400060.370-100000@ender.tmmz.net>
References: <Pine.BSF.4.43.0301011400060.370-100000@ender.tmmz.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Jan 2003 21:32:24 +0000
Message-Id: <1041456744.21748.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-01 at 19:19, Matthew Zahorik wrote:
> What is the correct behavior that I should implement?
> 
> a.  if !removable && not ready then error
> b.  if not ready then increase count until threshold then error
> c   if not ready then error
> d.  none of the above

I would go for a time limit (you don't want to keep spamming the same
command but to poll politely really IMHO)

