Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbTDHVWi (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTDHVWi (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:22:38 -0400
Received: from david.optusnet.com.au ([203.10.68.44]:14484 "EHLO
	david.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261789AbTDHVWg (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 17:22:36 -0400
Date: Wed, 9 Apr 2003 07:33:47 +1000
From: David Parrish <david.parrish@optusnet.com.au>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vfs level undelete support?
Message-ID: <20030408213347.GB29304@david.optusnet.com.au>
References: <1049772192.1243.186.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049772192.1243.186.camel@zaphod>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 11:23:12PM -0400, Shaya Potter wrote:

> Would there be any interest in a patch that added undelete support to
> the VFS.  the idea would be that when one unlink's a file, instead of it
> being deleted, it is "moved" to "/.undelete/d_put path of dentry",
> coupled with a daemon that manages the size (maintains a quota per uid
> by deleting old files).
> 
> It would appear to be an easy CONFIG level option, as it would just be
> do this, or normal unlink(), and would work for every fs, as well as not
> needing and LD_PRELOAD.

This has been implemented as a shared library which you can preload. It is
a wrapper around glibc's unlink() function which moves stuff to a trash
directory. This is probably better done this way in user space because it
allows the user quite a lot of freedom to decide which files get saved.

http://m-arriaga.net/software/libtrash/

-- 
Regards,
David Parrish
0410 586 121
