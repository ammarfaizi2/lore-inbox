Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUGMHXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUGMHXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 03:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUGMHXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 03:23:49 -0400
Received: from cantor.suse.de ([195.135.220.2]:41428 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263735AbUGMHXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 03:23:46 -0400
Date: Tue, 13 Jul 2004 09:23:44 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       jparadis@redhat.com, cagney@redhat.com
Subject: Re: [PATCH] x86-64 singlestep through sigreturn system call
Message-Id: <20040713092344.39ea00a3.ak@suse.de>
In-Reply-To: <200407130022.i6D0MUdI023333@magilla.sf.frob.com>
References: <200407130022.i6D0MUdI023333@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004 17:22:30 -0700
Roland McGrath <roland@redhat.com> wrote:


> This patch fixes the problem by forcing a fake single-step trap at the end
> of rt_sigreturn when PTRACE_SINGLESTEP was used to enter the system call.

I don't like this very much, see previous mail.

If you really wanted to do it:

Wouldn't it be simpler to just copy the TF bit from the previous Eflags? 
This special case looks quite ugly.

-Andi
