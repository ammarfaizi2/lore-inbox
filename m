Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030414AbWGZGkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030414AbWGZGkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:40:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030415AbWGZGkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:40:46 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:7836 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030414AbWGZGkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:40:46 -0400
Subject: Re: [patch] lockdep: annotate vfs_rmdir for filesystems that take
	i_mutex in delete_inode
From: Arjan van de Ven <arjan@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       reiser@namesys.com, viro@zeniv.linux.org.uk, viro@ftp.linux.org.uk,
       reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1153895524.2896.2.camel@laptopd505.fenrus.org>
References: <9a8748490607251516j1433306ek9c64cc84c0838f7b@mail.gmail.com>
	 <20060725223327.b6d039b2.akpm@osdl.org>
	 <1153895524.2896.2.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 08:38:28 +0200
Message-Id: <1153895908.2896.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 08:32 +0200, Arjan van de Ven wrote:
> > The VFS takes the directory i_mutex and reiserfs_delete_inode() takes the
> > to-be-deleted file's i_mutex.
> > 
> > That's notabug and lockdep will need to be taught about it.
> 
> Actually the annotation is in vfs_rmdir() since that is where the parent
> is taken (this may sound odd but the I_MUTEX_* ordering rules require
> the parent taking to be annotated rather than the child)


Ignore this; this one is wrong, more later

