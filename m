Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVJ0Mxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVJ0Mxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 08:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVJ0Mxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 08:53:46 -0400
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:32780 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750735AbVJ0Mxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 08:53:45 -0400
To: trond.myklebust@fys.uio.no
CC: bulb@ucw.cz, viro@ftp.linux.org.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <1130416523.14036.6.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Thu, 27 Oct 2005 08:35:23 -0400)
Subject: Re: [PATCH 2/8] VFS: per inode statfs (core)
References: <E1EU5bT-0005sq-00@dorka.pomaz.szeredi.hu>
	 <20051025042519.GJ7992@ftp.linux.org.uk>
	 <E1EUHbq-0006t6-00@dorka.pomaz.szeredi.hu>
	 <20051026173150.GB11769@efreet.light.src>
	 <E1EUqm3-00013A-00@dorka.pomaz.szeredi.hu>
	 <20051026195240.GB15046@efreet.light.src>
	 <E1EUrb7-0001AU-00@dorka.pomaz.szeredi.hu> <20051027080713.GA25460@djinn>
	 <E1EV338-0001vx-00@dorka.pomaz.szeredi.hu> <1130416523.14036.6.camel@lade.trondhjem.org>
Message-Id: <E1EV7Fd-0004XF-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Oct 2005 14:53:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, possibility for finding out where subfilesystems are located
> > _will_ be missing for such filesystems as sshfs.
> 
> Why? Can't lookup() notice the change in remote st_dev as you cross the
> filesystem boundary?

a) sftp is path based protocol, there's no separate lookup

b) sftp doesn't transfer st_ino or st_dev, they are both made up on
the client side

> For NFS the plan is to automatically submount such remote
> subfilesystems. That fixes a host of problems including the one that you
> mention w.r.t. statfs, the problem of potential duplicate inode numbers,
> etc.

That is fine.  It's clearly a superior sulution when the info is
available.  With sshfs the server simply doesn't care about mounts,
and so this is basically out of the question.

Miklos
