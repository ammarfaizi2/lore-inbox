Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbUKILGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUKILGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 06:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUKILG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 06:06:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:65461 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261499AbUKILGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 06:06:09 -0500
Date: Tue, 9 Nov 2004 03:05:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/11] oprofile: arch-independent code for stack trace
 sampling
Message-Id: <20041109030557.1de3f96a.akpm@osdl.org>
In-Reply-To: <1099996668.1985.783.camel@hole.melbourne.sgi.com>
References: <1099996668.1985.783.camel@hole.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Banks <gnb@melbourne.sgi.com> wrote:
>
> +	struct oprofile_cpu_buffer * cpu_buf = &cpu_buffer[smp_processor_id()];

oprofile is currently doing suspicious things with smp_processor_id() in
premptible reasons.  Is this patch compounding things?

