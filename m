Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUEYLKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUEYLKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 07:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUEYLKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 07:10:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:20615 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264543AbUEYLKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 07:10:07 -0400
Date: Tue, 25 May 2004 04:09:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IRQ stacks for PPC64
Message-Id: <20040525040934.14e20635.akpm@osdl.org>
In-Reply-To: <16563.9827.783950.254480@cargo.ozlabs.ibm.com>
References: <16563.9827.783950.254480@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> This patch implements separate per-cpu stacks for
>  processing interrupts and softirqs, along the lines of the
>  CONFIG_4KSTACKS stuff on x86.

Your show_stack()-from-irq code will need a bit of work to hop across to
the next stack.
