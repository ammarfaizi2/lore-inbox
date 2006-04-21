Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWDUVBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWDUVBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWDUVBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:01:37 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:31496 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932476AbWDUVBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:01:36 -0400
Date: Fri, 21 Apr 2006 23:01:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/16] GFS2: Makefiles and Kconfig
Message-ID: <20060421210139.GB26949@mars.ravnborg.org>
References: <1145636558.3856.118.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145636558.3856.118.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --- /dev/null
> +++ b/fs/gfs2/Makefile
> @@ -0,0 +1,42 @@
> +obj-$(CONFIG_GFS2_FS) += gfs2.o
> +gfs2-y := \
> +	acl.o \
> +	bits.o \
> +	bmap.o \
> +	daemon.o \
...
 +	trans.o \
> +	unlinked.o \
> +	util.o
A fewer number of lines please.
gfs2-y := acl.o bits.o bmap.o
...
gfs2-y += trans.o unlinked.o util.o


> +
> +obj-$(CONFIG_GFS2_FS_LOCKING_NOLOCK) += locking/nolock/
> +obj-$(CONFIG_GFS2_FS_LOCKING_DLM) += locking/dlm/
Can we get rid f the locking sub-directory - maybe like this:
+obj-$(CONFIG_GFS2_FS_LOCKING_NOLOCK) += no-lock/
+obj-$(CONFIG_GFS2_FS_LOCKING_DLM     += dlm-lock/

	Sam
