Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbUC2Xqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbUC2Xqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:46:52 -0500
Received: from hera.cwi.nl ([192.16.191.8]:54510 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263211AbUC2Xqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:46:49 -0500
Date: Tue, 30 Mar 2004 01:46:43 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] silence nfs mount messages
Message-ID: <20040329234643.GB17179@apps.cwi.nl>
References: <UTC200403291900.i2TJ0sC14336.aeb@smtp.cwi.nl> <1080587480.2410.61.camel@lade.trondhjem.org> <20040329195435.GA19426@apps.cwi.nl> <1080602653.2410.192.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1080602653.2410.192.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 06:24:13PM -0500, Trond Myklebust wrote:
> På må , 29/03/2004 klokka 14:54, skreiv Andries Brouwer:
> 
> > The features that are being used are used by layers of software.
> > If there is information to be passed, it should be passed to
> > that software, not printed in a syslog.
> > It is not the kernel's job to set policy and have an opinion about user mode setup.
> 
> What do you mean "setting policy"? Your program is attempting to use an
> obsolete kernel ABI. Of course it should "have an opinion" about that...
> 
> The issue is merely whether or not to issue an EINVAL, in order to force
> users to upgrade to an updated version of "mount":
> For 2.7.x, I'm rather of a mind to do just that in order to finally
> clean up the wretched struct nfs_mount and eliminate all the unused
> backward-compatibilty crap, but doing so in the middle of 2.6.x is not
> an option (particularly given that the SELinux mount changes came as
> late as they did).

The present situation is that the kernel comes with messages when
mount is recent and the kernel is old, and also when the kernel
is recent and mount is old. I object to both.

Mount tries the latest version it knows about, when that fails
goes back to an earlier version until either the mount succeeds
or we give up. The same binary must work over a large range of
kernel versions.

If you think that it would be terrible to have a nfs-v3 mount
succeed on a kernel that knows about nfs-v4 then I would prefer
to change the name of the filesystem to nfs4.

Andries

