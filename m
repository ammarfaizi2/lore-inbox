Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268514AbTGMOWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 10:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268516AbTGMOWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 10:22:53 -0400
Received: from wotug.org ([194.106.52.201]:24423 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S268514AbTGMOWw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 10:22:52 -0400
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Reply-To: Ruth.Ivimey-Cook@ivimey.org
To: linux-kernel@vger.kernel.org
Subject: Pointers/Info on 2.5 buffer management changes pls.
Date: Sun, 13 Jul 2003 15:37:53 +0100
User-Agent: KMail/1.5.2
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307131537.53343.ruth@ivimey.org>
X-Spam-Score: -0.4 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Bartlomiej has bullied me into trying to bring the ataraid driver into the 2.5 
world. I have so far created suitable build files and have started to look 
into the code changes. I have looked through the mail archives but it is very 
hard to find the right thing. So I would like to check:

1. the old code uses   MINOR(bh->b_rdev) to get the minor number of the 
ataraid device. Can I use   minor(bh->b_bdev->bd_inode->i_rdev)   to replace 
that?
[I am tempted to create an inline fn buffer_to_minor() for this purpose and 
put it in ataraid.h.]

2. the old code, in split_request, writes to b_rsector (2.4: the real sector 
on the disk) which has no obvious equivalent in 2.5. Can someone point me to 
a suitable file or email that I can use to resolve this?

Any other pointers accepted.

Thanks

Ruth

-- 
Engineer, Author and Webweaver

