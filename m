Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262705AbSJCAck>; Wed, 2 Oct 2002 20:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262706AbSJCAck>; Wed, 2 Oct 2002 20:32:40 -0400
Received: from thunk.org ([140.239.227.29]:33978 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262705AbSJCAcj>;
	Wed, 2 Oct 2002 20:32:39 -0400
Date: Wed, 2 Oct 2002 20:37:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
Message-ID: <20021003003739.GA4381@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <20021001195914.GC6318@stingr.net> <20021001204330.GO3000@clusterfs.com> <20021002104859.GD6318@stingr.net> <20021002165454.GV3000@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002165454.GV3000@clusterfs.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 10:54:54AM -0600, Andreas Dilger wrote:
> On Oct 02, 2002  14:48 +0400, Paul P Komkoff Jr wrote:
> > Unfortunately, there still one issue in ext3. It called "inode limit".
> > Initially I wanted to run this test on 1000000 files but ... I hit
> > inode limit and don't want to increase it artificially yet.
> > 
> > Reiserfs worked fine because it don't have such kind of limit ...
> 
> We have plans to fix this already, but it is not high enough on anyones
> priority list quite yet (most filesystems have enough inodes for regular
> usage).

Just to be clear, the limit which Paul is referring to is just simply
a matter of creating the filesystem with a sufficient number of
inodes.  (i.e., mke2fs -N 1200000).  Yes, having a dynamic inode table
would be good, but in practice sysadmins know how many inodes are
needed in advance.

						- Ted
