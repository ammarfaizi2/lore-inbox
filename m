Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVJ0MgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVJ0MgD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 08:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVJ0MgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 08:36:03 -0400
Received: from pat.uio.no ([129.240.130.16]:6866 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750717AbVJ0MgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 08:36:02 -0400
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: bulb@ucw.cz, viro@ftp.linux.org.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1EV338-0001vx-00@dorka.pomaz.szeredi.hu>
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu>
	 <20051025042519.GJ7992@ftp.linux.org.uk>
	 <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu>
	 <20051026173150.GB11769@efreet.light.src>
	 <E1EUqm3-00013A-00@dorka.pomaz.szeredi.hu>
	 <20051026195240.GB15046@efreet.light.src>
	 <E1EUrb7-0001AU-00@dorka.pomaz.szeredi.hu> <20051027080713.GA25460@djinn>
	 <E1EV338-0001vx-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 08:35:23 -0400
Message-Id: <1130416523.14036.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.814, required 12,
	autolearn=disabled, AWL 2.00, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 27.10.2005 klokka 10:23 (+0200) skreiv Miklos Szeredi:
> Yes, possibility for finding out where subfilesystems are located
> _will_ be missing for such filesystems as sshfs.

Why? Can't lookup() notice the change in remote st_dev as you cross the
filesystem boundary?

For NFS the plan is to automatically submount such remote
subfilesystems. That fixes a host of problems including the one that you
mention w.r.t. statfs, the problem of potential duplicate inode numbers,
etc.

Cheers,
  Trond

