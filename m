Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266107AbUFPDLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266107AbUFPDLC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 23:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbUFPDIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 23:08:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:47745 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266131AbUFPDA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 23:00:59 -0400
Date: Tue, 15 Jun 2004 20:00:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, mika@osdl.org
Subject: Re: [PATCH] security_sk_free void return fixup
Message-Id: <20040615200003.0100392a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406151946220.4142@ppc970.osdl.org>
References: <20040615161646.S21045@build.pdx.osdl.net>
	<Pine.LNX.4.58.0406151946220.4142@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Tue, 15 Jun 2004, Chris Wright wrote:
> >
> >   CHECK   net/core/sock.c
> > include/linux/security.h:2636:39: warning: return expression in void function
> >   CC      net/core/sock.o
> 
> I'm going to remove this warning from sparse. Apparently it is valid C99, 

yes, but in every(?) case where it triggered, the kernel code was wrong. 
So I'd suggest the warning be retained, perhaps with an option to enable
it.

