Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWDXNSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWDXNSI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWDXNSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:18:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28909 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750793AbWDXNSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:18:06 -0400
Subject: Re: [PATCH 13/16] GFS2: Makefiles and Kconfig
From: Steven Whitehouse <swhiteho@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060421210139.GB26949@mars.ravnborg.org>
References: <1145636558.3856.118.camel@quoit.chygwyn.com>
	 <20060421210139.GB26949@mars.ravnborg.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Mon, 24 Apr 2006 14:27:47 +0100
Message-Id: <1145885267.3856.147.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-04-21 at 23:01 +0200, Sam Ravnborg wrote:
> > --- /dev/null
> > +++ b/fs/gfs2/Makefile
> > @@ -0,0 +1,42 @@
> > +obj-$(CONFIG_GFS2_FS) += gfs2.o
> > +gfs2-y := \
> > +	acl.o \
> > +	bits.o \
> > +	bmap.o \
> > +	daemon.o \
> ...
>  +	trans.o \
> > +	unlinked.o \
> > +	util.o
> A fewer number of lines please.
> gfs2-y := acl.o bits.o bmap.o
> ...
> gfs2-y += trans.o unlinked.o util.o
> 
I've made it a fewer number of lines now:
http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=commitdiff;h=b5ea3e1ef307548bdd40fff6aba5fc96b002f284

> 
> > +
> > +obj-$(CONFIG_GFS2_FS_LOCKING_NOLOCK) += locking/nolock/
> > +obj-$(CONFIG_GFS2_FS_LOCKING_DLM) += locking/dlm/
> Can we get rid f the locking sub-directory - maybe like this:
> +obj-$(CONFIG_GFS2_FS_LOCKING_NOLOCK) += no-lock/
> +obj-$(CONFIG_GFS2_FS_LOCKING_DLM     += dlm-lock/
> 
> 	Sam

I'd rather keep the subdirectory if there are no strong objections to
it. Its quite likely that as time goes on, GFS will gather both further
locking modules and even other non-locking related modules which would
fit more naturally as subdirectories of fs/gfs2 directly,

Steve.


