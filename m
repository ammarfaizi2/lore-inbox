Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVEAGjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVEAGjs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 02:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbVEAGjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 02:39:47 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:42163 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261320AbVEAGjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 02:39:45 -0400
To: jamie@shareable.org
CC: hch@infradead.org, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-reply-to: <E1DS7RB-0004Md-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Sun, 01 May 2005 07:56:17 +0200)
Subject: Re: [PATCH] private mounts
References: <20050425071047.GA13975@vagabond> <E1DQ0Mc-0007B5-00@dorka.pomaz.szeredi.hu> <20050430083516.GC23253@infradead.org> <E1DRoDm-0002G9-00@dorka.pomaz.szeredi.hu> <20050430094218.GA32679@mail.shareable.org> <E1DRoz9-0002JL-00@dorka.pomaz.szeredi.hu> <20050430143609.GA4362@mail.shareable.org> <E1DRuNU-0002el-00@dorka.pomaz.szeredi.hu> <20050430164258.GA6498@mail.shareable.org> <E1DRvRc-0002lq-00@dorka.pomaz.szeredi.hu> <20050430235453.GA11494@mail.shareable.org> <E1DS7RB-0004Md-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1DS86r-0004PD-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 01 May 2005 08:39:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But proc_check_root is unnecessarily strict, in that it prevents a
> process from traversing into a "child" namespace.
> 
> IMHO, a better security restriction anyway would be for processes in
> chroot jails to not be able to see processes outside the jail in /proc
> - only processes inside the jail should be visible.  I think everyone
> agrees that would be best.

Creating a new namespace would also have the same effect (only
processes using that namespace are visible).  It would be rather ugly,
if a user could not see processes in other login sessions, just
because he uses private namespaces.

Miklos
