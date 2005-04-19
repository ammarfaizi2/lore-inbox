Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVDSPCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVDSPCT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 11:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVDSPCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 11:02:19 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:37570 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261578AbVDSPCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 11:02:12 -0400
Date: Tue, 19 Apr 2005 17:01:25 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: 7eggert@gmx.de, Miklos Szeredi <miklos@szeredi.hu>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
In-Reply-To: <a4e6962a050419045752cc8be0@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0504191647320.3652@be1.lrz>
References: <3Ki1W-2pt-1@gated-at.bofh.it> <3S8oN-So-17@gated-at.bofh.it> 
 <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> 
 <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> 
 <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> 
 <3UmnD-6Fy-7@gated-at.bofh.it>  <E1DNJZD-0006vK-11@be1.7eggert.dyndns.org>
 <a4e6962a050419045752cc8be0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Eric Van Hensbergen wrote:
> On 4/17/05, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>

> > > I was thinking about this a while back and thought having a user-mount
> > > permissions file might be the right way to address lots of these
> > > issues.  Essentially it would contain information about what
> > > users/groups were allowed to mount what sources to what destinations
> > > and with what mandatory options.
> > 
> > Users being able to mount random fs containing suid or device nodes
> > are root whenever they want to. If you want to mount with dev or suid,
> > use sudo and restrict the mount to a limited set of images/devices/whatever.
> 
> Well, that would kinda be the intent behind the permissions file  --
> it can specify what restricted set of images/devices/whatever the user
> can mount, I suppose the sensible thing would be to always enforce
> nosuid and nsgid, but I'd rather keep these as the default version of
> options (allowing admins to shoot themselves in the foot perhaps, but
> in the single-user workstation case, is seems like there's less reason
> to be so paranoid).

I think you shouldn't help the admins by creating shoes with target marks.

Allowing user mounts with no* should be allways ok (no config needed 
besides the ulimit), and mounting specified files to defined locations
is allready supported by fstab.
-- 
Top 100 things you don't want the sysadmin to say:
6. We prefer not to change the root password, it's an nice easy one
