Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130260AbRB1Qhr>; Wed, 28 Feb 2001 11:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130261AbRB1Qhh>; Wed, 28 Feb 2001 11:37:37 -0500
Received: from colorfullife.com ([216.156.138.34]:15890 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130260AbRB1QhX>;
	Wed, 28 Feb 2001 11:37:23 -0500
Message-ID: <3A9D2953.D4681F43@colorfullife.com>
Date: Wed, 28 Feb 2001 17:37:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: viro@math.psu.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel bug in inode.c:885 when floppy disk removed
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> - Doctor, it hurts when I do it! 
> - Don't do it, then. 
>
Interesting bugfix:
have you checked which BUG was triggered?

It's a bug in ext2_free_inode(): 
if a io error occurs, then clear_inode() is not called, but
super_operation.delete_inode() must call clear_inode() before returning.

--
	Manfred
