Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVERQdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVERQdm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 12:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVERQbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 12:31:43 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:2454 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262281AbVERQ3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 12:29:15 -0400
Date: Wed, 18 May 2005 09:24:17 -0400
From: Christopher Li <lkml@chrisli.org>
To: Timur Tabi <timur.tabi@ammasso.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sparse error: unable to open 'stdarg.h'
Message-ID: <20050518132417.GA14488@64m.dyndns.org>
References: <428A661C.1030100@ammasso.com> <20050517201148.GA12997@64m.dyndns.org> <428B4C67.5090307@ammasso.com> <20050518123854.GA13452@64m.dyndns.org> <428B646C.3030501@ammasso.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428B646C.3030501@ammasso.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2005 at 10:51:08AM -0500, Timur Tabi wrote:
> Christopher Li wrote:
> 
> >That is wired.  Can you try to edit a test.c contain just one line:
> >
> >#include <stdarg.h>
> >
> >run sparse on that test.c and see if you get any complain or not?
> 
> I did "sparse test.c" and got no output whatsoever.  No files were created, 
> either.

The sparse checker does not create files. That means your sparse is
fine. It should locate the stdarg.h

> There must be something specific about how kbuild calls sparse.

I think I know that it is. There is a "-nostdinc" in the sparse
options, which I saw it in the other email you send out. It
drop the internal include path. Gcc is does the same thing.

gcc -c -nostdinc /tmp/test.c
/tmp/test.c:1:22: no include path in which to find stdarg.h

Chris

