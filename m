Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWEAVbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWEAVbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWEAVbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:31:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53640 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932272AbWEAVbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:31:20 -0400
Date: Mon, 1 May 2006 14:33:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Herbert Poetzl <herbert@13thfloor.at>, Christoph Hellwig <hch@lst.de>
Subject: Re: 2.6.17-rc3 - fs/namespace.c issue
Message-Id: <20060501143344.3952ff53.akpm@osdl.org>
In-Reply-To: <200605012106.k41L6GNc007543@turing-police.cc.vt.edu>
References: <200605012106.k41L6GNc007543@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> There seems to have been a bug introduced in this changeset:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f6422f17d3a480f21917a3895e2a46b968f56a08
> 
> Am running 2.6.17-rc3-mm1.  When this changeset is applied, 'mount --bind'
> misbehaves:
> 
> > # mkdir /foo
> > # mount -t tmpfs -o rw,nosuid,nodev,noexec,noatime,nodiratime none /foo
> > # mkdir /foo/bar
> > # mount --bind /foo/bar /foo
> > # tail -2 /proc/mounts
> > none /foo tmpfs rw,nosuid,nodev,noexec,noatime,nodiratime 0 0
> > none /foo tmpfs rw 0 0
> 
> Reverting this changeset causes both mounts to have the same options.
> 
> (Thanks to Stephen Smalley for tracking down the changeset...)
> 

(cc's added)
