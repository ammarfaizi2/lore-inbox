Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317183AbSEXQNp>; Fri, 24 May 2002 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317188AbSEXQNo>; Fri, 24 May 2002 12:13:44 -0400
Received: from skye-demon.sychron.com ([62.49.236.27]:44532 "EHLO
	big-guy.sychron.com") by vger.kernel.org with ESMTP
	id <S317183AbSEXQNm>; Fri, 24 May 2002 12:13:42 -0400
Date: Fri, 24 May 2002 17:13:38 +0100 (BST)
From: John Bullock <jjb@sychron.com>
To: linux-kernel@vger.kernel.org
Subject: Releasing /proc inode numbers
Message-ID: <Pine.LNX.4.21.0205241701060.7694-100000@tomatin.sychron.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using kernel 2.4.9-ac10 there seems to be a bug in the releasing of
the inode numbers when unregistered proc entries.  I have been a kernel
module which sets its own proc_fops->readdir function that checks a
list in the module and then unregisters/registers entries within
the directory to represent that list, one entry per item in the list.  The
problem is that while the inode number for the first entry in the
directory is released and reused all the rest aren't.  Obviously the inode
numbers run out.
John

