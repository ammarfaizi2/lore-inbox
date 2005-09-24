Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVIXRkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVIXRkj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbVIXRki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:40:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932207AbVIXRki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:40:38 -0400
Date: Sat, 24 Sep 2005 10:39:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Sykes <chris@sigsegv.plus.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Message-Id: <20050924103946.540d708d.akpm@osdl.org>
In-Reply-To: <20050924142825.GA5158@sigsegv.plus.com>
References: <20050922163708.GF5898@sigsegv.plus.com>
	<20050923015719.5eb765a4.akpm@osdl.org>
	<20050923121932.GA5395@sigsegv.plus.com>
	<20050923132216.GA5784@sigsegv.plus.com>
	<20050923121811.2ef1f0be.akpm@osdl.org>
	<20050924121431.GA5530@sigsegv.plus.com>
	<20050924142825.GA5158@sigsegv.plus.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Sykes <chris@sigsegv.plus.com> wrote:
>
> On Sat, Sep 24, 2005 at 01:14:31PM +0100, Chris Sykes wrote:
>  > After many compile reboot cycles, git-bisect tells me that the
>  > offending cset is 10f47e6a1b8b276323b652053945c87a63a5812d:
>  >     [PATCH] ext2: Enable atomic inode security labeling
>  > 
>  > I'll do some more testing to verify.
> 
>  Latest kernel from git (2.6.14-rc2-g87e807b6) still causes the problem
>  for me.  Reversing cset 10f47e6a1b8b276323b652053945c87a63a5812d fixes
>  it for me.

Good stuff, thanks.

>  I'll build a kernel with CONFIG_EXT2_FS_XATTR disabled and see if that
>  also makes the issue go away.

Yup.  I thought I already tested wth your .config?
