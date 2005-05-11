Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVEKTqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVEKTqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVEKTqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:46:13 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:47302 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262034AbVEKTqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:46:06 -0400
Date: Wed, 11 May 2005 21:46:14 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: serue@us.ibm.com
cc: Miklos Szeredi <miklos@szeredi.hu>, jamie@shareable.org, 7eggert@gmx.de,
       ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
In-Reply-To: <20050511190545.GB14646@serge.austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0505112137100.11888@be1.lrz>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it>
 <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it>
 <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
 <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
 <20050511190545.GB14646@serge.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005 serue@us.ibm.com wrote:
> Quoting Miklos Szeredi (miklos@szeredi.hu):

> > > > > How about a new clone option "CLONE_NOSUID"?
> > > > 
> > > > IMO, the clone call ist the wrong place to create namespaces. It should be
> > > > deprecated by a mkdir/chdir-like interface.
> > > 
> > > And the mkdir/chdir interface already exists, see "cd /proc/NNN/root".
> > 
> > That's the chdir part.
> > 
> > The mkdir part is clone() or unshare().
> 
> Right, sys_unshare(), as per Janak's patch.  Does it lack anything which
> you would need?

e.g.

create_persistent_namespace(char* name)
destroy_persistent_namespace(char* name)
list_persistent_namespaces(char * prefix, uint flags)
# flags & 1: 1=list all namespaces minus prefix
#            0=trim names at the first slash after stripping prefix

-- 
Funny quotes:
27. If people from Poland are called Poles, why aren't people from Holland
    called Holes?
