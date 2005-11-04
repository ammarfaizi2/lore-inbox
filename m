Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932732AbVKDM4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbVKDM4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVKDM4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:56:36 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:10 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932732AbVKDM4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:56:35 -0500
To: jblunck@suse.de
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
In-reply-to: <20051104122021.GA15061@hasse.suse.de> (jblunck@suse.de)
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek() bugfix
References: <20051104113851.GA4770@hasse.suse.de> <20051104115101.GH7992@ftp.linux.org.uk> <20051104122021.GA15061@hasse.suse.de>
Message-Id: <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 04 Nov 2005 13:56:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 
> > > SuSV3 only says: "If a file is removed from or added to the
> > > directory after the most recent call to opendir() or
> > > rewinddir(), whether a subsequent call to readdir_r() returns an
> > > entry for that file is unspecified."
> >  
> > IOW, the applications in question are broken since they rely on
> > unspecified behaviour, not provided by old libc versions.
> 
> No. SuSV3 only says that the behavior of readdir() is unspecified
> w.r.t. an entry for the removed/added file. I think readdir() should
> still return the entries which are not removed/added. What do you
> think?

What 'rm' is this?  Mine (coreutils 5.2.1) doesn't do any seeking and
I don't think that glibc does either.

Miklos
