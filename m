Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbTJCJLd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 05:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTJCJLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 05:11:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:31379 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263646AbTJCJLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 05:11:31 -0400
Date: Fri, 3 Oct 2003 02:12:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vsyscall page in core dumps
Message-Id: <20031003021251.627dd922.akpm@osdl.org>
In-Reply-To: <200310030156.h931uZhL015129@magilla.sf.frob.com>
References: <200310030156.h931uZhL015129@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> My change to core dumps that was included with the vsyscall DSO
>  implementation had a bug (braino on my part).  Core dumps don't include the
>  full page of the vsyscall DSO, and so don't accurately represent the whole
>  memory image of the process.  This patch fixes it.  I have tested it on
>  x86, but not tested the same change to 32-bit core dumps on AMD64 (haven't
>  even compiled on AMD64).
> 
>  I've also included the corresponding change for the IA64 code that was
>  copied blindly from the x86 vsyscall implementation, which looks like more
>  change than it is since I preserved the formatting of the copied code
>  instead of arbitrarily diddling it along with the trivial symbol name
>  changes.

How does one test it?

> I haven't compiled or tested on ia64.

I have.  GATE_BASE is undefined.  Replacing it with GATE_ADDR makes it
build OK, but that's all I can say.

