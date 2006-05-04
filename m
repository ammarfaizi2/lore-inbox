Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWEDVlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWEDVlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 17:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWEDVlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 17:41:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50110 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751338AbWEDVla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 17:41:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <84144f020605040737k316fd5abva4476da69a65c084@mail.gmail.com> 
References: <84144f020605040737k316fd5abva4476da69a65c084@mail.gmail.com>  <20060504031755.GA28257@hellewell.homeip.net> <20060504033829.GE28613@hellewell.homeip.net> 
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: "Phillip Hellewell" <phillip@hellewell.homeip.net>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, "James Morris" <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, "Erez Zadok" <ezk@cs.sunysb.edu>,
       "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH 6/13: eCryptfs] Superblock operations 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 04 May 2006 22:40:49 +0100
Message-ID: <23457.1146778849@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg <penberg@cs.helsinki.fi> wrote:

> > +       ecryptfs_printk(KERN_DEBUG, "Enter; inode = [%p]\n", inode);
> > +       crypt_stat = &(ECRYPTFS_INODE_TO_PRIVATE(inode))->crypt_stat;
> > +       ecryptfs_destruct_crypt_stat(crypt_stat);
> > +       kmem_cache_free(ecryptfs_inode_info_cache,
> > +                       ECRYPTFS_INODE_TO_PRIVATE(inode));
> 
> Better to introduce a local variable for CRYPTFS_INODE_TO_PRIVATE.
> More readable and smaller kernel text that way.

But it may use more stack, which is a much more limited resource, so what you
suggest is not necessarily the best thing to do.

David
