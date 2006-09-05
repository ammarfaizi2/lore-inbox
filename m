Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWIEEpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWIEEpo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 00:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWIEEpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 00:45:43 -0400
Received: from [213.184.169.125] ([213.184.169.125]:15488 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750708AbWIEEpn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 00:45:43 -0400
From: Al Boldi <a1426z@gawab.com>
To: =?utf-8?q?J=C3=B6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Date: Tue, 5 Sep 2006 07:46:44 +0300
User-Agent: KMail/1.5
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk, Pavel Machek <pavel@suse.cz>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060903110507.GD4884@ucw.cz> <20060904125744.GA1961@wohnheim.fh-wedel.de>
In-Reply-To: <20060904125744.GA1961@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200609050746.44502.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Sun, 3 September 2006 11:05:08 +0000, Pavel Machek wrote:
> > > - Modifying a Unionfs branch directly, while the union is mounted, is
> > >   currently unsupported.  Any such change may cause Unionfs to oops
> > > and it can even result in data loss!
> >
> > I'm not sure if that is acceptable. Even root user should be unable to
> > oops the kernel using 'normal' actions.
>
> Direct modification of branches is similar to direct modification of
> block devices underneith a mounted filesystem.  While I agree that
> such a thing _should_ not oops the kernel, I'd bet that you can easily
> run a stresstest on a filesystem while randomly flipping bits in the
> block device and get just that.

Not really a fair comparison.  The block level is conceptionally totally 
different than the fs level, while a stackable fs is within the realms of 
the fs level.

> There are bigger problems in unionfs to worry about.

Agreed.  Moving basic functionality abstractions into the VFS could easily 
alleviate theses kinds of problems.


Thanks!

--
Al

