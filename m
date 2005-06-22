Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262944AbVFVJql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262944AbVFVJql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbVFVJmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:42:52 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:32006 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262867AbVFVJic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:38:32 -0400
To: akpm@osdl.org
CC: miklos@szeredi.hu, pavel@ucw.cz, linux-kernel@vger.kernel.org
In-reply-to: <20050622021251.5137179f.akpm@osdl.org> (message from Andrew
	Morton on Wed, 22 Jun 2005 02:12:51 -0700)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
	<E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	<20050621142820.GC2015@openzaurus.ucw.cz>
	<E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	<20050621220619.GC2815@elf.ucw.cz>
	<E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
	<20050621233914.69a5c85e.akpm@osdl.org>
	<E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
	<20050622004902.796fa977.akpm@osdl.org>
	<E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu> <20050622021251.5137179f.akpm@osdl.org>
Message-Id: <E1Dl1Oz-0007Dq-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jun 2005 11:20:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  We could.  But that would again be overly restrictive.  The goal is to
> >  make the use of FUSE filesystems for users as simple as possible.  If
> >  the user has to manage multiple namespaces, each with it's own
> >  restrictions, it's becoming a very un-user-friendly environment.
> 
> I'd have thought that it would be possible to offer the same user interface
> as you currently have with private namespaces.  Hide any complexity in the
> userspace tools?  Where's the problem?

Sorry, I don't get it.

You mean implement the permission checking in the userspace
filesystem?  That doesn't work, since it's running with the privileges
of the filesystem owner, and as such obviously cannot be trusted with
checking for access by other users.

Thanks,
Miklos
