Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVD3K7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVD3K7e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 06:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVD3K7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 06:59:34 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:60848 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261188AbVD3K7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 06:59:33 -0400
To: miklos@szeredi.hu
CC: hch@infradead.org, 7eggert@gmx.de, smfrench@austin.rr.com,
       linux-kernel@vger.kernel.org
In-reply-to: <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Sat, 30 Apr 2005 11:22:48 +0200)
Subject: Re: [PATCH] cifs: handle termination of cifs oplockd kernel thread
References: <3YLdQ-4vS-15@gated-at.bofh.it> <E1DRekV-0001RN-VQ@be1.7eggert.dyndns.org> <20050430073238.GA22673@infradead.org> <E1DRn70-0002AD-00@dorka.pomaz.szeredi.hu> <20050430082952.GA23253@infradead.org> <E1DRoBU-0002Fk-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1DRpfS-0002Nc-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 30 Apr 2005 12:57:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  - network/userspace filesystems should be fine aswell
> 
> They should, but again I wonder if NFS with all it's complexity is
> being careful enough with what it accepts from the server.
> 
> Smbfs might be close to safe, since it's already available for users
> to mount from an arbitrary server.

I take that back.  Any filesystem using page cache and allowing shared
writable mapping is currently unsafe because of OOM deadlock if
mounted from local machine, or simply DoS against client by delaying
writeback.

So other than FUSE, what's left as safe?

Miklos
