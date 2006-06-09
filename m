Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWFIRCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWFIRCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 13:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbWFIRCC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 13:02:02 -0400
Received: from [80.71.248.82] ([80.71.248.82]:23187 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S1030238AbWFIRCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 13:02:00 -0400
X-Comment-To: Linus Torvalds
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alex Tomas <alex@clusterfs.com>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org, Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<4488E1A4.20305@garzik.org>
	<20060609083523.GQ5964@schatzie.adilger.int>
	<44898EE3.6080903@garzik.org> <448992EB.5070405@garzik.org>
	<Pine.LNX.4.64.0606090836160.5498@g5.osdl.org>
	<m33beecntr.fsf@bzzz.home.net>
	<Pine.LNX.4.64.0606090913390.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
From: Alex Tomas <alex@clusterfs.com>
Organization: HOME
Date: Fri, 09 Jun 2006 21:04:08 +0400
In-Reply-To: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org> (Linus Torvalds's message of "Fri, 9 Jun 2006 09:54:49 -0700 (PDT)")
Message-ID: <m3y7w69s6v.fsf@bzzz.home.net>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



oops :) I don't follow that well ... 

size of in-core inodes is a different problem.

thanks, Alex

>>>>> Linus Torvalds (LT) writes:

 LT> On Fri, 9 Jun 2006, Linus Torvalds wrote:
 >> 
 >> Just as an example: ext3 _sucks_ in many ways. It has huge inodes that 
 >> take up way too much space in memory.

 LT> Btw, I'm not kidding you on this one.

 LT> THE NUMBER ONE MEMORY USAGE ON A LOT OF LOADS IS EXT3 INODES IN MEMORY!

 LT> And you know what? 2TB files are totally uninteresting to 99.9999% of all 
 LT> people. Most people find it _much_ more interesting to have hundreds of 
 LT> thousands of _smaller_ files instead.

 LT> So do this:

 LT> 	cat /proc/slabinfo | grep ext3

 LT> and be absolutely disgusted and horrified by the size of those inodes 
 LT> already, and ask yourself whether extending the block size to 48 bits will 
 LT> help or further hurt one of the biggest problems of ext3 right now?

 LT> (And yes, I realize that block numbers are just a small part of it. The 
 LT> "vfs_inode" is also a real problem - it's got _way_ too many large 
 LT> list-heads that explode on a 64-bit kernel, for example. Oh, well. My 
 LT> point is that things like this can make a very real issue _worse_ for all 
 LT> the people who don't care one whit about it)

 LT> 		Linus
