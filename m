Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUH0SrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUH0SrC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 14:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUH0SrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 14:47:01 -0400
Received: from clusterfw.beelinegprs.ru ([217.118.66.232]:56667 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S267209AbUH0Spl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 14:45:41 -0400
Date: Fri, 27 Aug 2004 22:38:59 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christophe Saout <christophe@saout.de>, Hans Reiser <reiser@namesys.com>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040827183858.GF5108@backtop.namesys.com>
References: <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <1093467601.9749.14.camel@leto.cs.pocnet.net> <20040825225933.GD5618@nocona.random> <412DA0B5.3030301@namesys.com> <20040826112818.GL5618@nocona.random> <1093520699.9004.11.camel@leto.cs.pocnet.net> <20040826121630.GN5618@nocona.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826121630.GN5618@nocona.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:16:30PM +0200, Andrea Arcangeli wrote:
> On Thu, Aug 26, 2004 at 01:44:59PM +0200, Christophe Saout wrote:
> > I think you're not exactly understanding what a reiser4 "plugin" is.
> > 
> > Currently plugins are not modules. It just means that there's a defined
> > interface between the reiser4 core and the plugins. Just like you could
> > see filesystems as "VFS plugins".
> 
> but filesystems are exactly always modules (in precompiled kernels at
> least).
> 
> Anyways I don't see any visible EXPORT_SYMBOL in reiser4.

they would be there, I think.
> 
> > 
> > In fact, reiser4 plugins are
> > - users of the reiser4 core API
> > - some of them are implementing Linux VFS methods (thus being some sort
> > of glue code between the Reiser4 storage tree and the Linux VFS)
> 
> then it seems a bit misleading to call those things plugins.

There should be infracture to change plugin on fly, and choosing object's
plugins at object's creation time.  Currently only certain object's plugins
can be changed through <object>/metas/plugin interface. 

> 
> As you wrote those are "users of the reiser4 core API", with plugins I
> always meant dynamically loadable things, like plugins for web browers
> (hence kernel modules in kernel space). While here apparently you can't
> plugin anything at runtime, it's just code that uses the reiser4 core
> API that can be modified with a kernel patch as usual.

-- 
Alex.
