Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTGBSyI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTGBSyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:54:07 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:36970 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264389AbTGBSxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:53:22 -0400
Date: Wed, 2 Jul 2003 12:02:28 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-Id: <20030702120228.13d72290.akpm@digeo.com>
In-Reply-To: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jul 2003 19:07:47.0082 (UTC) FILETIME=[395486A0:01C340CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>
> akpm:
> 
> > You'll note that loop.c goes from (page/offset/len) to (addr/len),
> > and this transfer function then immediately goes from (addr,len)
> > to (page/offset/len). That's rather silly ..
> 
> Changing that would kill all existing modules that use the loop device.

That's OK - if they don't want to properly adapt to the new API they can
just kmap the page and call into the old-style code.  A five-line wrapper.

> Maybe nobody cares. Then we can do so in a subsequent patch.

Splitting these changes into two almost doubles the testing effort, or
halves the coverage.  We really should aim to get both these changes in
place at the same time.  I know that I wouldn't bother testing it if there
are more large changes pending...

Could we pleeeze have a little cryptoloop.txt which just gives the basics
on where to obtain the tools and how to get the thing up and running?  It's
a right pain having to go scrabbling all over the internet working out how
to set stuff up if you just want to do a bit of testing every few months.

Thanks.

(Where are the first and second patches btw?  Merged?  Is a fourth
anticipated?)


