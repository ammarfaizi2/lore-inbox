Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWDUXBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWDUXBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 19:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWDUXBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 19:01:51 -0400
Received: from ns1.suse.de ([195.135.220.2]:33748 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750708AbWDUXBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 19:01:50 -0400
Date: Fri, 21 Apr 2006 16:00:35 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] GFS2: Makefiles and Kconfig
Message-ID: <20060421230035.GA11190@kroah.com>
References: <1145636558.3856.118.camel@quoit.chygwyn.com> <20060421164309.GE19754@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421164309.GE19754@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2006 at 06:43:09PM +0200, Adrian Bunk wrote:
> > --- /dev/null
> > +++ b/fs/gfs2/Kconfig
> > @@ -0,0 +1,46 @@
> > +config GFS2_FS
> > +        tristate "GFS2 file system support"
> > +	default m
> > +	depends on EXPERIMENTAL
> > +        select FS_POSIX_ACL
> > +        select SYSFS
> >...
> 
> - tabs <-> spaces (tabs are correct)
> - please remove the "default m"
> - "depends on SYSFS" instead of the select

Why do you depend on sysfs at all?  If it's not enabled, your code
should still build just fine, right?  If not, please let us know and we
will fix the build error in the sysfs.h header file.

thanks,

greg k-h
