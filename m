Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUAVHP2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 02:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUAVHP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 02:15:28 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:49032 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S264419AbUAVHP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 02:15:27 -0500
Date: Thu, 22 Jan 2004 07:17:39 +0000
From: Jonathan Boler <j.m.boler@sms.ed.ac.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Stale Filehandles was: [2.6] nfs_rename: target $file busy,
 d_count=2
Message-Id: <20040122071739.1376f824.j.m.boler@sms.ed.ac.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 10:40:31AM -0800, Mike Fedyk wrote:
> > I only had a few nfs clients doing light load, (kde home directories, and
> > such) and was able to reproduce stale nfs file handles just by running "find
> > > /dev/null" on the nfs share.
> >
> > Have you tried the -mm tree recently? 2.6.1-mm4 even has some new nfsd
> > patches in there (maybe you should wait until -mm5 though, there are a few
> 
> Stale filehandles is the main problem right now, and I don't see how
> nfs_raname would be related (just that it was there while I was having
> trouble with the stale file handles...)
> 
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/nfsd-01-stale-filehandles-fixes.patch
> 
> This one looks particularly interesting...

I was getting alot of nfsv3 stale file handles with 2.6.1-mm1 so I dropped back to 2.6.1.

mm5 seems to have fixed everything.

Jonathan
