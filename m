Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272567AbTHSSKO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 14:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272521AbTHSSJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 14:09:05 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42761
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272335AbTHSSAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 14:00:36 -0400
Date: Tue, 19 Aug 2003 11:00:28 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, andrea@suse.de, green@namesys.com,
       marcelo@conectiva.com.br, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-ID: <20030819180028.GB19465@matchmail.com>
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, andrea@suse.de,
	green@namesys.com, marcelo@conectiva.com.br, akpm@osdl.org,
	linux-kernel@vger.kernel.org, mason@suse.com
References: <20030813125509.360c58fb.skraw@ithnet.com> <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain> <20030813145940.GC26998@namesys.com> <20030813171224.2a13b97f.skraw@ithnet.com> <20030813153009.GA27209@namesys.com> <20030819011208.GK10320@matchmail.com> <20030819091243.007acac0.skraw@ithnet.com> <1061298621.30565.31.camel@dhcp23.swansea.linux.org.uk> <20030819161832.2a0bae58.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819161832.2a0bae58.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 19, 2003 at 04:18:32PM +0200, Stephan von Krawczynski wrote:
> On 19 Aug 2003 14:10:22 +0100
> Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> 
> > On Maw, 2003-08-19 at 08:12, Stephan von Krawczynski wrote:
> > > > Are you saying that one CPU can't saturate the memory bus?  Or maybe
> > > > we're hitting something on the CPU bus, or just that SMP will change the
> > > > timings and stress things differently?  Or that if memtest doesn't test
> > > > from the second CPU then it could be a faulty cpu/L2?
> > > 
> > > Well, if memtest does not use a second available CPU then probably we
> > > should ask the author about this...
> > 
> > I'm sure he'd give you a quote for adding SMP support if you asked.
> 
> Well, actually I don't want to burn down his time as long as I don't see a need
> for it. Since I am pretty confident to make the box work in SMP under 2.4.20 a
> memtest will most certainly not give any additional information, be it running
> UP or SMP.
> Instead I will invest another day and convert the whole system back to
> reiserfs, because the ext3 fs cannot be used under 2.4.20 - I don't know why.
> Additionally reiserfs is better for testing possible patches because it crashes
> in much shorter time than ext3 setup.
> 2.4.20 setup gives me a simple testcase to prove people right or wrong that are
> talking about a hardware issue.

Are you doing a lot of directory operations, or is it mostly just large
amounts of data transfering over NFS?

The reason why I ask, is that I know that at least JFS and possibly XFS uses
trees for their directory structures, and might show similar problems (with
its large use of trees), if you did a lot of directory operations on the
other filesystems.

Then maybe it could rule out reiserfs.  Though it still did show up on ext3...
