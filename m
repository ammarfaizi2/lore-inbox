Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUHHOVP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUHHOVP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 10:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUHHOVP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 10:21:15 -0400
Received: from colin2.muc.de ([193.149.48.15]:16910 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265395AbUHHOVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 10:21:08 -0400
Date: 8 Aug 2004 16:21:07 +0200
Date: Sun, 8 Aug 2004 16:21:07 +0200
From: Andi Kleen <ak@muc.de>
To: Paul Jackson <pj@sgi.com>
Cc: David Ford <david+challenge-response@blue-labs.org>,
       linux-kernel@vger.kernel.org
Subject: Re: warning: comparison is always false due to limited range of data type
Message-ID: <20040808142107.GB94449@muc.de>
References: <411562FD.5040500@blue-labs.org> <20040807174133.1e368fbc.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807174133.1e368fbc.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 05:41:33PM -0700, Paul Jackson wrote:
> david+challenge-response@blue-labs.org wrote:
> > fs/smbfs/inode.c:563: warning: comparison is always false due to limited 
> > range of data type
> > fs/smbfs/inode.c:564: warning: comparison is always false due to limited 
> > range of data type
> 
> You're lucky you're still on the cc list David - please don't use reply
> addresses that require editing.
> 
> Adding Andi Kleen <ak@muc.de> to cc list - looks from the bk log that he
> might have some interest in this.

Sorry, I forgot what I changed here. At least my original
changes didn't cause warnings as far as I know. Someone else please
take care of it.

-Andi

> 
> fs/smbfs/inode.c
>   1.46 03/12/01 07:04:55 ak@muc.de[torvalds] +2 -2
>   UID16 fixes
> 
> bk diffs -r1.45..1.46 fs/smbfs/inode.c
> ===== fs/smbfs/inode.c 1.45 vs 1.46 =====
> 554,555c554,555
> <               mnt->uid = OLD_TO_NEW_UID(oldmnt->uid);
> <               mnt->gid = OLD_TO_NEW_GID(oldmnt->gid);
> ---
> >               SET_UID(mnt->uid, oldmnt->uid);
> >               SET_GID(mnt->gid, oldmnt->gid);
> 
> -- 
>                           I won't rest till it's the best ...
>                           Programmer, Linux Scalability
>                           Paul Jackson <pj@sgi.com> 1.650.933.1373
