Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVAGDSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVAGDSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 22:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVAGDSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 22:18:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:7149 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261286AbVAGDRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 22:17:55 -0500
Date: Thu, 6 Jan 2005 19:17:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: hch@infradead.org, viro@parcelfarce.linux.theplanet.co.uk,
       paulmck@us.ibm.com, arjan@infradead.org, linux-kernel@vger.kernel.org,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-Id: <20050106191735.0421cdca.akpm@osdl.org>
In-Reply-To: <1105055333.17166.304.camel@localhost.localdomain>
References: <20050106190538.GB1618@us.ibm.com>
	<1105039259.4468.9.camel@laptopd505.fenrus.org>
	<20050106201531.GJ1292@us.ibm.com>
	<20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	<20050106210408.GM1292@us.ibm.com>
	<20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	<20050106152621.395f935e.akpm@osdl.org>
	<20050106234123.GA27869@infradead.org>
	<20050106162928.650e9d71.akpm@osdl.org>
	<1105055333.17166.304.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Gwe, 2005-01-07 at 00:29, Andrew Morton wrote:
>  > Christoph Hellwig <hch@infradead.org> wrote:
>  > Fine.  Completely agree.  Sometimes people do need to be forced to make
>  > such changes - I don't think anyone would disagree with that.
>  > 
>  > What's under discussion here is "how to do it".  Do we just remove things
>  > when we notice them, or do we give (say) 12 months notice?
> 
>  Why should we keep junk around for 12 months

To give people a reasonable amount of time to stop using these things, of
course.

> that nobody has a legal reason to be using ?

The symbols were exported to non-gpl modules.  People used them.  Maybe
they shouldn't have.  Maybe they were asked not to do so, and maybe or
maybe not they noticed.  Certainly we shouldn't have exported these things
in the first place.

We should find a way of repairing things while minimising the amount of
screwing people around.
