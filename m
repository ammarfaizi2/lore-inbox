Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313920AbSDJWx1>; Wed, 10 Apr 2002 18:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313921AbSDJWx0>; Wed, 10 Apr 2002 18:53:26 -0400
Received: from red.csi.cam.ac.uk ([131.111.8.70]:29917 "EHLO red.csi.cam.ac.uk")
	by vger.kernel.org with ESMTP id <S313920AbSDJWxZ>;
	Wed, 10 Apr 2002 18:53:25 -0400
Message-Id: <5.1.0.14.2.20020410235415.03d41d00@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 10 Apr 2002 23:56:41 +0100
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [prepatch] address_space-based writeback
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <3CB4B248.2807558D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 22:44 10/04/02, Andrew Morton wrote:
>When a page is marked dirty, the path which is followed
>is page->mapping->host->i_sb.  So in this case the page will
>be attached to its page->mapping.dirty_pages, and
>page->mapping->host will be attached to page->mapping->host->i_sb.s_dirty
>
>This is as it always was - I didn't change any of this.

Um, NTFS uses address spaces for things where ->host is not an inode at all 
so doing host->i_sb will give you god knows what but certainly not a super 
block!

As long as your patches don't break that is possible to have I am happy... 
But from what you are saying above I have a bad feeling you are somehow 
assuming that a mapping's host is an inode...

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

