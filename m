Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264534AbTFEIyz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 04:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTFEIyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 04:54:54 -0400
Received: from [81.2.65.18] ([81.2.65.18]:43534 "EHLO mail.humboldt.co.uk")
	by vger.kernel.org with ESMTP id S264534AbTFEIyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 04:54:53 -0400
Date: Thu, 5 Jun 2003 10:11:20 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
To: "Frank Cusack" <fcusack@fcusack.com>
Cc: trond.myklebust@fys.uio.no, linux-kernel@vger.kernel.org
Subject: Re: nfs_refresh_inode: inode number mismatch
Message-Id: <20030605101120.2bea125a.adrian@humboldt.co.uk>
In-Reply-To: <20030604142047.C24603@google.com>
References: <20030603165438.A24791@google.com>
	<shswug2sz5x.fsf@charged.uio.no>
	<20030604142047.C24603@google.com>
Organization: Humboldt Solutions Ltd
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jun 2003 14:20:47 -0700
"Frank Cusack" <fcusack@fcusack.com> wrote:

> On Wed, Jun 04, 2003 at 04:19:38PM +0200, Trond Myklebust wrote:
> > >>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:
> >      > At this point, fs/nfs/inode.c:__nfs_refresh_inode() prints
> >      > the"inode number mismatch" error.  AFAICT, this is just
> >      > noise, but the noise is driving me crazy. :-)
> > 
> > Inode number mismatch points to either an an obvious server error
> > (it is not providing unique filehandles) or corruption of the fattr
> > struct that was passed to nfs_refresh_inode().

There's a very common cause on embedded boards that don't have
real-time clocks. Without a clock the client uses the same XID on every
run, leading to lots of these messages. Is your clock broken?

- Adrian Cox
http://www.humboldt.co.uk/
