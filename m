Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262192AbSJNVqD>; Mon, 14 Oct 2002 17:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262193AbSJNVqD>; Mon, 14 Oct 2002 17:46:03 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:37026 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S262192AbSJNVqB>; Mon, 14 Oct 2002 17:46:01 -0400
Message-Id: <200210142151.g9ELpiLG101376@pimout1-ext.prodigy.net>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA)) (fwd)
Date: Mon, 14 Oct 2002 12:41:28 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Nick LeRoy <nleroy@cs.wisc.edu>, Hans Reiser <reiser@namesys.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0210132107020.9247-100000@steklov.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0210132107020.9247-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 October 2002 09:09 pm, Alexander Viro wrote:
> > Logically, the second /var mount should be "mount --move /initrd/var
> > /var", followed by "umount /initrd" to free up the initrd memory.  Right
> > now it's doing "mount -n --bind /initrd/var /var", because /etc is a
> > symlink into /var (has to remain editable, you see), and this way the
> > information about which partition var actually is can be kept in one
> > place.  (This is an implementation detail: I could have used volume
> > labels instead.)
> >
> > The point is, right now I can't free the initial ramdisk because it has
> > an active mount point under it..
>
> umount -l
> mount --move

Cool.  Thanks.

Rob

(Serves me right for still having Red Hat 7.2 on my laptop.  Old man pages.  
Now I've got to find a new project to force myelf to learn VFS internals.  Oh 
well... :)

(Nit-pick:  the man page description of umount -l doesn't look like it'd help 
with the removable media problem, I.E. "umount --gimme_my_cd_back_NOW", but 
the code may disagree, and the discussion's already turned up a 2.4 patch 
from Tirgran via Hugh Dickens, so I'll shut up now. :)
