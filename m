Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVDSPVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVDSPVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 11:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVDSPVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 11:21:40 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:20615 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261601AbVDSPVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 11:21:38 -0400
To: 7eggert@gmx.de
CC: ericvh@gmail.com, 7eggert@gmx.de, miklos@szeredi.hu,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <Pine.LNX.4.58.0504191647320.3652@be1.lrz> (message from Bodo
	Eggert on Tue, 19 Apr 2005 17:01:25 +0200 (CEST))
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <3Ki1W-2pt-1@gated-at.bofh.it> <3S8oN-So-17@gated-at.bofh.it> 
 <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> 
 <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> 
 <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> 
 <3UmnD-6Fy-7@gated-at.bofh.it>  <E1DNJZD-0006vK-11@be1.7eggert.dyndns.org>
 <a4e6962a050419045752cc8be0@mail.gmail.com> <Pine.LNX.4.58.0504191647320.3652@be1.lrz>
Message-Id: <E1DNuXS-0008IP-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 Apr 2005 17:21:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I think you shouldn't help the admins by creating shoes with target marks.
> 
> Allowing user mounts with no* should be allways ok (no config needed 
> besides the ulimit), and mounting specified files to defined locations
> is allready supported by fstab.

I tend to agree.  It should be obvious which sort of mounts are safe
and which are not.  The exceptions can go into fstab.

In a private namespace environment bind mounts (nodev,nosuid) should
be OK.  Network filesystems (with limitations to the ports used) are
also.  Disk filesystems are usually not safe to mount for users,
because they are not tested and verified against untrusted source.

Miklos
