Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVAGA3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVAGA3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbVAGA3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:29:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:42973 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbVAGAZD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:25:03 -0500
Date: Thu, 6 Jan 2005 16:29:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-Id: <20050106162928.650e9d71.akpm@osdl.org>
In-Reply-To: <20050106234123.GA27869@infradead.org>
References: <20050106190538.GB1618@us.ibm.com>
	<1105039259.4468.9.camel@laptopd505.fenrus.org>
	<20050106201531.GJ1292@us.ibm.com>
	<20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	<20050106210408.GM1292@us.ibm.com>
	<20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	<20050106152621.395f935e.akpm@osdl.org>
	<20050106234123.GA27869@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> > I think the exports should be restored.  So does Linus ("Not that I like it
> > all that much, but I don't think we should break existing modules unless we
> > have a very specific reason to break just those modules.").
> 
> No.  I specificly asked the question how they're using it and they're use is
> 
>  a) completely buggy
>  b) poking so deep in the kernel that the user falls under the GPL
>     derived works clause.  As a copyright holder of quite a bit of fs/*.c
>     I certainly wouldn't give IBM a special exception to use it even if
>     it was exported.
> 
> These exports were only added for intermezzo during 2.4.x and with the
> removal of intermezzo they go.  They never were a public API, and that they
> were needed at all was a managment mistake in how that code was merged.

Fine.  Completely agree.  Sometimes people do need to be forced to make
such changes - I don't think anyone would disagree with that.

What's under discussion here is "how to do it".  Do we just remove things
when we notice them, or do we give (say) 12 months notice?
