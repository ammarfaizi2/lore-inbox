Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262430AbSKUB1N>; Wed, 20 Nov 2002 20:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262790AbSKUB1N>; Wed, 20 Nov 2002 20:27:13 -0500
Received: from hera.cwi.nl ([192.16.191.8]:57788 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262430AbSKUB1N>;
	Wed, 20 Nov 2002 20:27:13 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 21 Nov 2002 02:33:45 +0100 (MET)
Message-Id: <UTC200211210133.gAL1Xjw05852.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: kill i_dev
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We can kill i_dev.  
> BTW, watch out for socket.c use of ->i_dev.

Yes, I looked at that but concluded that someone (you?)
had added the assignment just to preserve the guarantee
previously given by get_empty_inode() at the moment it
was replaced by new_inode(). But it is superfluous, I think.

> However, rdev and [cb]dev will have to remain separate.

We can fight later on that one. My point of view is
that just like i_dev is a field in i_sb, also i_rdev
can be retrieved from i_[cb]dev.

Something else is kdev_t. I liked it when it was a pointer.
Now it is just garbage and the kernel is full of conversions
to and from. Is there any reason not to throw out all of kdev_t?
That is, is there a reason to have a kdev_t different from dev_t?

Andries

