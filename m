Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280537AbRKBDfi>; Thu, 1 Nov 2001 22:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280538AbRKBDf3>; Thu, 1 Nov 2001 22:35:29 -0500
Received: from dsl-213-023-038-228.arcor-ip.net ([213.23.38.228]:59149 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S280537AbRKBDfV>;
	Thu, 1 Nov 2001 22:35:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Ext2 directory index, updated
Date: Fri, 2 Nov 2001 04:36:25 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15zV86-0000o4-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the htree directory index patch for ext2, updated to 2.4.13.  
***N.B.: still for use on test partitions only.***

I ran it through some basic tests, up to half a million files/directory, 
without problems.  There are still a few minor warts to clean up, including 
still not having settled on a final-final hash function, although it looks 
likely that it's going to end up being dx_hack_hash, with a more respectable 
name.

I'm not 100% sure I've handled kmap/highmem correctly, and I haven't checked 
that yet.

This patch is just a snapshot of my work-in-progress.  There will be an 
update in another day or so, and a to-do list.  There are a few extra hash 
functions in the code from various sources, including reiserfs and bitkeeper, 
which I'll remove in the next update.  Those who find this kind of thing 
interesting may find these... interesting.

The patch is available at:

  http://nl.linux.org/~phillips/htree/ext2.index-2.4.13

To apply:

  cd /your/source/tree
  patch -p0 <this.patch

--
Daniel
