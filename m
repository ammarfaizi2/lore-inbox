Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135794AbRDZRrl>; Thu, 26 Apr 2001 13:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133004AbRDZRrV>; Thu, 26 Apr 2001 13:47:21 -0400
Received: from ravage.rit.edu ([129.21.2.220]:19584 "HELO ravage.unixthugs.org")
	by vger.kernel.org with SMTP id <S135799AbRDZRrK>;
	Thu, 26 Apr 2001 13:47:10 -0400
Message-ID: <3AE85F24.1010208@suse.com>
Date: Thu, 26 Apr 2001 13:47:16 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Reiserfs List <reiserfs-list@namesys.com>
Subject: [PATCH/URL] Endian Safe ReiserFS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I've just completed my port of ReiserFS to be endian safe. The patch 
has been tested successfully on x86 (UP/SMP), ppc (UP/SMP), and 
UltraSparc (UP). I've received reports that it also works successfully 
on mips (UP).

   The patch preserves the little-endian disk format, so a disk can be 
moved across architectures. The on-disk format has not been altered, so 
the code can be patched in without disruption to users with existing 
reiserfs filesystems (like myself :)). There are no VFS changes.

   Due to the patches affecting all of ReiserFS, the patch is quite 
large (180K), and so in the interests of preserving bandwidth for 
everyone, I've decided to post a URL to the patch instead.

   The patch can be found at: 
http://penguinppc.org/~jeffm/releases/endian-safe-reiserfs-for-2.4.4-pre7.final.bz2

   More information, including the endian safe utiltities, can be found 
at http://penguinppc.org/~jeffm.

   -Jeff

