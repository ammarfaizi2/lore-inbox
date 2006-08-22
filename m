Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWHVUXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWHVUXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 16:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWHVUXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 16:23:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6539 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751249AbWHVUXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 16:23:42 -0400
Message-Id: <200608222023.k7MKNHpH018036@pasta.boston.redhat.com>
To: Solar Designer <solar@openwall.com>
cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: printk()s of user-supplied strings (Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again)
In-Reply-To: Your message of "Tue, 22 Aug 2006 07:07:55 +0400."
             <20060822030755.GB830@openwall.com>
Date: Tue, 22 Aug 2006 16:23:17 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22-Aug-2006 at 7:7 +0400, Solar Designer wrote:

> On Mon, Aug 21, 2006 at 07:36:01PM -0400, Ernie Petrides wrote:
> > -			printk(KERN_ERR "Unable to load interpreter %.128s\n",
> > -				elf_interpreter);
>
> I'd rather have this message rate-limited, not dropped completely.

I consider any printk() that can be arbitrarily triggered by an
unprivileged user to be inappropriate, rate-limited or not.  I
recommend that it be removed entirely.


> Another long-time concern that I had is that we've got some printk()s
> of user-supplied string data.  What about embedded linefeeds - can this
> be used to produce fake kernel messages with arbitrary log level (syslog
> priority)?  It certainly seems so.
>
> Also, there are terminal controls...

These are valid concerns.  Allowing the kernel to print user-fabricated
strings is a terrible idea.


Cheers.  -ernie
