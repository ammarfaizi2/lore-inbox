Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbUKQTtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbUKQTtt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262521AbUKQTrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:47:03 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:62137 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262510AbUKQTqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:46:23 -0500
To: pavel@ucw.cz
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20041117190055.GC6952@openzaurus.ucw.cz> (message from Pavel
	Machek on Wed, 17 Nov 2004 20:00:55 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz>
Message-Id: <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 17 Nov 2004 20:45:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Coda should do the job, too... What are advantages of FUSE over Coda?

No, it couldn't do the job half as well.  You know, I did use Coda,
until I had enough of it.  Now look at how many userspace filesystems
were written based on CODA and how many on FUSE.

Coda is very different.  You can only read/write whole files in Coda.
It's got a different attribute invalidation modell, a different access
checking modell.  Generally it's much less flexible, which is OK since
it was not designed for this job.  On the other hand it has things
which most filesystems don't need (reintegration).

So while on the surface they might seem similar, there's really not
that much common between them.

There's LUFS which is _much_ more close to FUSE, but it isn't as good
either (well of course, since it isn't written by me ;).

Miklos
