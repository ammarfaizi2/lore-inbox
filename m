Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWARVXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWARVXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWARVXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:23:20 -0500
Received: from pat.uio.no ([129.240.130.16]:64448 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964928AbWARVXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:23:19 -0500
Subject: RE: [PATCH 2/3] Fix problems on multi-TB filesystem and file
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Takashi Sato <sho@tnes.nec.co.jp>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Andreas Dilger'" <adilger@clusterfs.com>, torvalds@osdl.org,
       viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <000101c61c2e$59230b20$4168010a@bsd.tnes.nec.co.jp>
References: <000101c61c2e$59230b20$4168010a@bsd.tnes.nec.co.jp>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 16:22:48 -0500
Message-Id: <1137619368.8706.42.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.02, required 12,
	autolearn=disabled, AWL 1.79, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 21:54 +0900, Takashi Sato wrote:
> > CONFIG_LFS would become a specialised option for embedded systems and
> > for the minority of people who self-compile kernels.  I just don't
> > think that's worth the maintainability hassle.
> 
> I added CONFIG_LSF to use large filesystem over network with >2TB file
> even on a small system as CONFIG_LBD disable.  And I heard that some
> people dislike network filesystems depending on block device.
> 
> Trond, do you have comments about integrating CONFIG_LFS and
> CONFIG_LBD?

If you do merge CONFIG_LFS and CONFIG_LBD, then please throw out the
name CONFIG_LBD in favour of CONFIG_LFS, since the resulting option will
_not_ be block device specific.

Unless someone has some really good arguments against it, I too would
vote for hiding both options behind CONFIG_EMBEDDED.

Cheers,
  Trond

