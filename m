Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267497AbUIAXID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267497AbUIAXID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUIAXAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:00:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:977 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267507AbUIAW5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:57:53 -0400
Date: Wed, 1 Sep 2004 16:01:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: jh@sgi.com, limin@engr.sgi.com, linux-kernel@vger.kernel.org,
       jlan@engr.sgi.com, erikj@sgi.com, chrisw@osdl.org
Subject: Re: [PATCH] improving JOB kernel/user interface
Message-Id: <20040901160127.3ee02f0b.akpm@osdl.org>
In-Reply-To: <20040901130623.F1924@build.pdx.osdl.net>
References: <4134FE16.2000308@engr.sgi.com>
	<20040901193829.GJ5886@sgi.com>
	<20040901130623.F1924@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * John Hesterberg (jh@sgi.com) wrote:
> > The current job /proc ioctl interface is really a fake-syscall interface.
> > We only did that so that our product didn't have to lock into a syscall
> > number that would eventually be used by something else.
> > 
> > The easiest thing for us would probably be to turn it back into a system
> > call, if that would be acceptable for inclusion into the kernel.  We're
> > open to other job interfaces, such as a real /proc character interface,
> > or a new virtual filesystem, or a device driver using ioctls.
> 
> But that system call would still be a single mutliplexor for many calls, right?

Either that, or 19 separate syscalls...

> Not ideal.  Have you tried to map to an fs?

That's worth investigation.
