Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbTDHVZx (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbTDHVZw (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:25:52 -0400
Received: from cs.columbia.edu ([128.59.16.20]:52465 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id S261886AbTDHVZt (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:25:49 -0400
Subject: Re: vfs level undelete support?
From: Shaya Potter <spotter@cs.columbia.edu>
To: David Parrish <david.parrish@optusnet.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030408213347.GB29304@david.optusnet.com.au>
References: <1049772192.1243.186.camel@zaphod>
	 <20030408213347.GB29304@david.optusnet.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1049837739.14099.14.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Apr 2003 17:35:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-08 at 17:33, David Parrish wrote:
> On Mon, Apr 07, 2003 at 11:23:12PM -0400, Shaya Potter wrote:
> 
> > Would there be any interest in a patch that added undelete support to
> > the VFS.  the idea would be that when one unlink's a file, instead of it
> > being deleted, it is "moved" to "/.undelete/d_put path of dentry",
> > coupled with a daemon that manages the size (maintains a quota per uid
> > by deleting old files).
> > 
> > It would appear to be an easy CONFIG level option, as it would just be
> > do this, or normal unlink(), and would work for every fs, as well as not
> > needing and LD_PRELOAD.
> 
> This has been implemented as a shared library which you can preload. It is
> a wrapper around glibc's unlink() function which moves stuff to a trash
> directory. This is probably better done this way in user space because it
> allows the user quite a lot of freedom to decide which files get saved.

except it doesn't work w/ statically linked or non glibc linked
binaries, hence really isn't a complete solution.  could be good enough
though.

