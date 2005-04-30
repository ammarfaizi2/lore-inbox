Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVD3RId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVD3RId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 13:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVD3RId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 13:08:33 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:58033 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261305AbVD3RI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 13:08:29 -0400
To: jamie@shareable.org
CC: hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <20050430164258.GA6498@mail.shareable.org> (message from Jamie
	Lokier on Sat, 30 Apr 2005 17:42:58 +0100)
Subject: Re: [PATCH] private mounts
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <E1DPofK-0000Yu-00@localhost> <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050430094218.GA32679@mail.shareable.org> <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu> <20050430143609.GA4362@mail.shareable.org> <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu> <20050430164258.GA6498@mail.shareable.org>
Message-Id: <E1DRvRc-0002lq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Apr 2005 19:07:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But you don't need a new system call to bind an fd.
> 
> "mount --bind /proc/self/fd/N mount_point" works, try it.

Ahh, yes :)

Still proc_check_root() has to be relaxed, to allow dereferencing link
under a different namespace.  Maybe the check should be skipped for
capable(CAP_SYS_ADMIN) or similar.

What do people think about that?

Miklos
