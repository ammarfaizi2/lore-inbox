Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293373AbSBZBlX>; Mon, 25 Feb 2002 20:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292631AbSBZBlH>; Mon, 25 Feb 2002 20:41:07 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:33668 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293349AbSBZBkr>;
	Mon, 25 Feb 2002 20:40:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] Son of Unbork (1 of 3)
Date: Sun, 24 Feb 2002 03:33:36 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.GSO.4.21.0202251323160.3162-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0202251323160.3162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16eoTq-0001GK-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 25, 2002 07:28 pm, Alexander Viro wrote:
> On Sat, 23 Feb 2002, Daniel Phillips wrote:
> > Please tell me who wrote this:
> > 
> > struct super_operations {
> >         struct inode *(*alloc_inode)(struct super_block *sb);
> >         void (*destroy_inode)(struct inode *)
> 
> I had.  With inodes it _does_ provide things that can't be done
> without these methods.  Namely, common allocation of generic and
> fs-private part *on* *the* *fast* *path* *for* *class* *with*
> *many* *instances*.
> 
> The latter parts are missing in case of superblocks.  We don't
> allocate hundreds of thousands of superblocks.  Moreover, ones
> allocated live much longer than normal struct inode.
> 
> IOW, common allocation is worthless in this case and that's the
> only rationale for ->alloc_inode()/->destroy_inode().

You are being random.  I'll leave the patch as it stands, I'm satisfied with 
it.  If you want to change it, go ahead, you have it in your mailbox.  Tear 
the whole thing up and rewrite it if you like.  Just don't delay this 
important work because of stupid personality issues.

-- 
Daniel
