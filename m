Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVEDOeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVEDOeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 10:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVEDOeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 10:34:46 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:20242 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261841AbVEDOeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 10:34:31 -0400
To: tali@admingilde.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, smfrench@austin.rr.com, hch@infradead.org
In-reply-to: <20050504134717.GD3562@admingilde.org> (message from Martin Waitz
	on Wed, 4 May 2005 15:47:17 +0200)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu> <20050504134717.GD3562@admingilde.org>
Message-Id: <E1DTKwt-0003s6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 04 May 2005 16:34:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This (lightly tested) patch against 2.6.12-rc* adds some
> > infrastructure and basic functionality for unprivileged mount/umount
> > system calls.
> 
> most of this unprivileged mount policy can be handled by a suid
> userspace helper (e.g. pmount)

Yes.  This patch was created because certain people (including myself
to some extent) don't like that approach.

> what are the pros/cons of handling that in the kernel?

pro:

  - mount would still work in "suidless" private namespace

con:

  - kernel bloat

I'm sure there are others, they just elude me for the moment :)

Thanks,
Miklos
