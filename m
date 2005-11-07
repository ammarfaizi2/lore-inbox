Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVKGR0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVKGR0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVKGR0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:26:52 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:50127 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965307AbVKGRYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:24:50 -0500
From: ext3crypt@comcast.net
To: fawadlateef@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: RE: Am I thinking correctly?
Date: Mon, 07 Nov 2005 17:24:48 +0000
Message-Id: <110720051724.6127.436F8DDF0006D246000017EF22007348309B9F979D0CCC9B980A@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: ZXh0M2NyeXB0QGNvbWNhc3QubmV0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the previous failed responses .. I never use this webmail interface, and it was set to send mail using HTML.

------  Here is the reply . . .


Kernel Version:  2.6.13
 
The API will be used, but I am using a simple xor to test with.
 
The data is getting written to disk, but NOT the buffer I'm sending to submit_bh().  It is writing the buffers from the page I copied???
 
No messages.  I just do the following:
 
mount the filesystem
cd to it's root
cp foo foo2
sync
(at this point everything looks fine)
 
cd ..
umount the filesystem
mount the filesystem
cd to it's root
cat foo2 (which is now the wrong data)
 
I'll attach the code tonight when I have access to it.
 
 
 
-------------- Original message -------------- 

> On 11/7/05, ext3crypt wrote: 
> > I'm working on a masters project for PSU. It requires that I modify the 
> > ext3 and fs code in the kernel proper. 
> > 
> > The idea is to encrypt data just prior to it being written to disk. I've 
> > created a new version of __block_write_full_page (which is called from 
> > writepage) to allocate a new (GFP_NOFS) page, setup the buffer_head list and 
> > copy the data to the new page (and encrypt it too). When I do this, the 
> > data is not written to disk from the new buffer_head that I submit using 
> > submit_bh(). I've treked through this code and I'm convinced I'm down the 
> > right path. Am I? Any assistance would be appreciated. 
> > 
> 
> Which kernel version you are using ? 
> Using kernel Encryption API ? 
> How you got to know that your data is not written to disk ? Getting 
> any error message ? or some-thing else ? 
> And a url or attachment of code will help others to get to your problem ! 
> 
> 
> -- 
> Fawad Lateef 
> - 
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in 
> the body of a message to majordomo@vger.kernel.org 
> More majordomo info at http://vger.kernel.org/majordomo-info.html 
> Please read the FAQ at http://www.tux.org/lkml/ 
