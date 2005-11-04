Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVKDQjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVKDQjg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVKDQjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:39:36 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:4879 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932165AbVKDQjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:39:35 -0500
To: trond.myklebust@fys.uio.no
CC: jblunck@suse.de, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
In-reply-to: <1131121642.8806.42.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Fri, 04 Nov 2005 11:27:21 -0500)
Subject: Re: [RFC,PATCH] libfs dcache_readdir() and dcache_dir_lseek()
	bugfix
References: <20051104113851.GA4770@hasse.suse.de>
	 <20051104115101.GH7992@ftp.linux.org.uk>
	 <20051104122021.GA15061@hasse.suse.de>
	 <E1EY16w-0004HC-00@dorka.pomaz.szeredi.hu>
	 <20051104131858.GA16622@hasse.suse.de>
	 <E1EY1fi-0004LB-00@dorka.pomaz.szeredi.hu>
	 <20051104151104.GA22322@hasse.suse.de> <1131121642.8806.42.camel@lade.trondhjem.org>
Message-Id: <E1EY4al-0004lb-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 04 Nov 2005 17:39:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The new bug is rather that glibc will return EOVERFLOW, and try to
> rewind your file pointer if your filesystem happens to return 64-bit
> offsets to getdents64().

Well, that's sort of understandable.  It has to map unique 64-bit
offsets to unique 32-bits offsets, which is rather hard.

Miklos

