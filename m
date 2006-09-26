Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751711AbWIZHHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbWIZHHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 03:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWIZHHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 03:07:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751700AbWIZHHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 03:07:24 -0400
Date: Tue, 26 Sep 2006 00:07:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: Martin Bligh <mbligh@google.com>, LKML <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: 2.6.18-mm1 compile failure on x86_64
Message-Id: <20060926000714.bd12361b.akpm@osdl.org>
In-Reply-To: <200609260841.27413.ak@suse.de>
References: <45185A93.7020105@google.com>
	<200609260841.27413.ak@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 08:41:27 +0200
Andi Kleen <ak@suse.de> wrote:

> On Tuesday 26 September 2006 00:39, Martin Bligh wrote:
> > http://test.kernel.org/abat/49037/debug/test.log.0	
> > 
> >    AS      arch/x86_64/boot/bootsect.o
> >    LD      arch/x86_64/boot/bootsect
> >    AS      arch/x86_64/boot/setup.o
> >    LD      arch/x86_64/boot/setup
> >    AS      arch/x86_64/boot/compressed/head.o
> >    CC      arch/x86_64/boot/compressed/misc.o
> >    OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
> > BFD: Warning: Writing section `.data.percpu' to huge (ie negative) file 
> > offset 0x804700c0.
> 
> Most likely that is the problem. I don't know what patch it could be
> (none of mine have been merged yet).

That was 2.6.18-mm1 - it has around 300 of "yours" ;)

> Can you bisect?

I was unable to reproduce it.  Lack of disk space is suspected.
