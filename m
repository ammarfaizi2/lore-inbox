Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292079AbSBYSUk>; Mon, 25 Feb 2002 13:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292082AbSBYSUU>; Mon, 25 Feb 2002 13:20:20 -0500
Received: from dsl-213-023-039-132.arcor-ip.net ([213.23.39.132]:37760 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292079AbSBYSUL>;
	Mon, 25 Feb 2002 13:20:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] Son of Unbork (1 of 3)
Date: Sat, 23 Feb 2002 20:13:06 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <Pine.GSO.4.21.0202251231290.3162-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0202251231290.3162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ehbW-00008F-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 25, 2002 06:34 pm, Alexander Viro wrote:
> On Mon, 25 Feb 2002, Alexander Viro wrote:
> > On Sat, 23 Feb 2002, Daniel Phillips wrote:
> 
> > > Patch 1 adds alloc_super and destroy_super methods to struct file_system.  A 
> > Vetoed.
> 
> To elaborate: there is no reason why private stuff couldn't be allocated
> by ext2_fill_super() and freed by ext2_put_super().  What's more, there
> is no reason why it would break for any other fs.  IOW, new methods are
> not necessary.  Now apply Occam's Razor.

Please tell me who wrote this:

struct super_operations {
        struct inode *(*alloc_inode)(struct super_block *sb);
        void (*destroy_inode)(struct inode *)

-- 
Daniel
