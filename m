Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVAGWAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVAGWAK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVAGV56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 16:57:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:11425 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261616AbVAGV4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 16:56:10 -0500
Date: Fri, 7 Jan 2005 14:00:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: mingo@elte.hu, hch@infradead.org, viro@parcelfarce.linux.theplanet.co.uk,
       paulmck@us.ibm.com, arjan@infradead.org, linux-kernel@vger.kernel.org,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-Id: <20050107140034.46aec534.akpm@osdl.org>
In-Reply-To: <20050107091542.GA5295@infradead.org>
References: <1105039259.4468.9.camel@laptopd505.fenrus.org>
	<20050106201531.GJ1292@us.ibm.com>
	<20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	<20050106210408.GM1292@us.ibm.com>
	<20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
	<20050106152621.395f935e.akpm@osdl.org>
	<20050106234123.GA27869@infradead.org>
	<20050106162928.650e9d71.akpm@osdl.org>
	<20050107002624.GA29006@infradead.org>
	<20050107090014.GA24946@elte.hu>
	<20050107091542.GA5295@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jan 07, 2005 at 10:00:14AM +0100, Ingo Molnar wrote:
> > so my strong position is that even asking for any 'warning period' for
> > changes in VFS internals (including exports/unexports) would be
> > extremely rude.

No, I'd say that unexports are different.  They can clearly break existing
code and so should only be undertaken with caution, and with lengthy notice
if possible.

And it _is_ possible here, because there are no plans to change the
exported functions, and it's only two lines of code, dammit.

The cost to us of maintaining those two lines of code for a year is
basically zero.

The cost to others of us removing those two lines of code without warning
is appreciable.

Obvious solution: don't remove the two lines of code without warning.

The only reason I can see for peremptorily removing those two lines of code
is that there is some benefit to doing so which outweighs the downstream
cost of doing so.  Nobody has demonstrated such a benefit.

> <sarcasm>
> <osdl-salespitch>
> Unfortunately you don't have the financial and political powers IBM
> has, so your opinion doesn't matter as much.  Maybe you should become
> OSDL member to influence the direction of Linux development.
> </osdl-salespitch>
> </sarcasm>

Christoph, it would be better to constraint yourself to commenting on other
people's actions rather than entering into premature speculation regarding
their motivations, especially when that speculation involves accusations of
corruption.

I have outlined the reasons for delaying the removal of these exports.  If
you can demonstrate that those reasons are invalid, and that I had good
reason for also believing that those reasons are invalid then that would be
an appropriate stage at which to start to speculate about ulterior
motivations, thanks very much.  
