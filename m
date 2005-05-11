Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVEKKbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVEKKbY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 06:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVEKKbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 06:31:24 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:36616 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261957AbVEKKbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 06:31:20 -0400
To: hch@infradead.org
CC: ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com
In-reply-to: <20050511085154.GB24495@infradead.org> (message from Christoph
	Hellwig on Wed, 11 May 2005 09:51:54 +0100)
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <E1DSyQx-0002ku-00@dorka.pomaz.szeredi.hu> <a4e6962a05050406086e3ab83b@mail.gmail.com> <E1DTKkd-0003rC-00@dorka.pomaz.szeredi.hu> <20050511085154.GB24495@infradead.org>
Message-Id: <E1DVoUW-0001cN-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 May 2005 12:31:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, I see your point.  However the problem of malicious filesystem
> > "traps" applies to private namespaces as well (because of suid
> > programs).
> > 
> > So if a user creates a private namespace, it should have the choice of:
> > 
> >    1) Giving up all suid rights (i.e. all mounts are cloned and
> >       propagated with nosuid)
> > 
> >    2) Not giving up suid for cloned and propagated mounts, but having
> >       extra limitations (suid/sgid programs cannot access unprivileged
> >       "synthetic" mounts)
> 
> Although I hate special cases I think that we might need 2) to avoid too
> much trouble tripping over the global namespace.

I think it should be both.  How about a new clone option "CLONE_NOSUID"?

Miklos
