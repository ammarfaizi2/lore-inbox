Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291272AbSCDLHt>; Mon, 4 Mar 2002 06:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291484AbSCDLHk>; Mon, 4 Mar 2002 06:07:40 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:60564 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S291272AbSCDLHb>;
	Mon, 4 Mar 2002 06:07:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Ext2 Directory Index, updated
Date: Mon, 4 Mar 2002 12:03:27 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hqFb-0000co-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After some considerable time letting this patch 'age', here's an update
to 2.4.18:

   http://people.nl.linux.org/~phillips/htree/htree-2.4.18

The diff to 2.4.17 was provided by Ted Ts'o, and bug hunting/fixing by
Chris Li (who has the rather interesting email address
<chrisl@gnuchina.org>).  Chris is working on the Ext3 port as well.

Bill Irwin is providing loving care and attention to the hash function, so I 
feel it's in good hands.

Known Bug:

  - highmem doesn't work (because the kmapping code is wrong)

To Do:

  - Finalize hash function.
  - Coalesce on delete.  I have to do this sooner rather than later,
    since hash bucket fragmentation leads quickly to reduced leaf
    fullness.
  - Stable telldir cookie for NFS
  - Ext2 util updates (in progress, Ted Ts'o)
  - Miscellaneous source cleanups

Because of the unfinalized hash function, this patch is still for testing 
only.

-- 
Daniel
