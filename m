Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbVA2Rqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbVA2Rqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 12:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVA2Rqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 12:46:34 -0500
Received: from peabody.ximian.com ([130.57.169.10]:29320 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261482AbVA2Rpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 12:45:34 -0500
Subject: Re: system calls
From: Robert Love <rml@novell.com>
To: Rodrigo Ramos <rodrigo.ramos@triforsec.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1107006832.2732.35.camel@ZeroOne>
References: <1107006832.2732.35.camel@ZeroOne>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 12:47:38 -0500
Message-Id: <1107020858.11159.15.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-29 at 10:53 -0300, Rodrigo Ramos wrote:

> I would like to know how many groups of system calls are there at Linux
> 2.4 and 2.6? Where can I find these informations in the Kernel?

I don't know what you mean by groups (a nonempty set G with binary
operation * s.t. G is associativity, there exists e in G s.t. e*a=a*e=a,
and there exists i in G s.t. i*b=b*i=e?).

System calls are implemented per-architecture.  You can see the list at
the bottom of arch/i386/kernel/entry.S.  There is about 290.

System calls are prefixed by "sys_".  Thus, read(2) is implemented in
the kernel as sys_read().  It, for example, can be found in
fs/read_write.c.

Hope this helps.

	Robert Love




