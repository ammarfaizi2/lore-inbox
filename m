Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUFTTwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUFTTwh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 15:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265923AbUFTTwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 15:52:37 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:23525 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S264097AbUFTTwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 15:52:34 -0400
Message-ID: <cb5afee1040620125272ab9f06@mail.gmail.com>
Date: Sun, 20 Jun 2004 15:52:33 -0400
From: Jeremy <jeremy.katz@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
Cc: Jeff Garzik <jgarzik@pobox.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Andrew Morton <akpm@osdl.org>, Linus <torvalds@osdl.org>,
       linuxppc64-dev@lists.linuxppc.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040618151753.GA21596@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040618165436.193d5d35.sfr@canb.auug.org.au> <40D305B4.4030009@pobox.com> <20040618151753.GA21596@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 16:17:53 +0100, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Jun 18, 2004 at 11:09:40AM -0400, Jeff Garzik wrote:
> > Stephen Rothwell wrote:
> > >This patch adds a proc file for viodasd so to make it
> > >easier to enumerate the available disks.  It is in a
> > >(somewhat) strange format to try for a simple level of
> > >compatability with the old viodasd code (that was in a
> > >couple of vendor's kernels).
> > 
> > Exporting redundant information from procfs is a step backwards, since
> > we have sysfs.
> >
> > I would prefer not to apply this.  Upstream is for 'getting it right',
> > not for dragging every little vendor kernel hack along.

It was in the tree for the platform, not just vendor trees.  ie,
anyone who wanted to use the platform with Linux would have had this
functionality.  If you'd argue that people shouldn't do that, then how
are platforms supposed to get to a point where they can be included in
the mainline tree?

Also, it's exactly the sort of thing that would have been accepted in
2.4 if the platform had tried to get included there.  So this is a bit
of bogus reasoning.  eg, if there was an attempt to include iSeries in
the 2.4 series now (or a year ago, when it might have been more
reasonable), this would have gone in.  It's an interface that users of
the platform have come to depend on, for better or for worse.

And the information is hardly redundant when the same information
isn't really available in /sys at present.  And before it's mentioned,
/sys/block isn't the same information.

> Agreed.  And the old viodasd reason was rejected exactly because it was
> such a f***ing mess.

The argument could be made that sysfs is similarly a f***ing mess and
that instead of solving problems, it creates more.  The mess of
symlinks present there is a disaster and disgusting for anyone who
wants to actually write clean probing code.    Also, things in sysfs
aren't exactly stable enough to count on as a dependable interface,
but that's something the kernel has never reliably exported to
userspace.

Jeremy
