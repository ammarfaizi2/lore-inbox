Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265398AbUFCAP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUFCAP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 20:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265396AbUFCAP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 20:15:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:30166 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265398AbUFCAP6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 20:15:58 -0400
Date: Wed, 2 Jun 2004 17:17:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, rusty@rustcorp.com.au,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040602171724.2221f97e.akpm@osdl.org>
In-Reply-To: <20040602165902.73dfc977.pj@sgi.com>
References: <20040602161115.1340f698.pj@sgi.com>
	<20040602162330.0664ec5d.akpm@osdl.org>
	<20040602165902.73dfc977.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> > Can't we just stick a PAGE_SIZE in here?
> 
> We could - either way works about as well.  Is there something special
> about PAGE_SIZE here?  Is that in fact what sysfs is making available?

Think so.  Greg, can you confirm that a SYSDEV_ATTR's handler can safely
assume that it has a PAGE_SIZE buffer to write to?

