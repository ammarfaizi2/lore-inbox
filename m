Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUEJWNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUEJWNc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUEJWNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:13:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:28574 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261673AbUEJWNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:13:24 -0400
Date: Mon, 10 May 2004 15:15:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040510151554.49965f1d.akpm@osdl.org>
In-Reply-To: <20040510230558.A8159@infradead.org>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<20040510223755.A7773@infradead.org>
	<20040510150203.3257ccac.akpm@osdl.org>
	<20040510230558.A8159@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > Capabilities are broken and don't work.  Nobody has a clue how to provide
> > the required services with SELinux and nobody has any code and we need the
> > feature *now* before vendors go shipping even more ghastly stuff.
> 
> The thing is special privilegues for a group don't fit into any of the
> various privilegues schemes we have (capabilities, selinux, etc..),
> it's really a horrible hack.

It beats the alternatives which are floating about, which includes a sysctl
which defeats CAP_SYS_MLOCK system-wide.

>  What happened to the patch rick promised
> to make mlock an rlimit?  This is the right approach and could be easily
> extended to hugetlb pages.

rlimits don't work for this.  shm segments persist after process exit and
aren't associated with a particular user.

