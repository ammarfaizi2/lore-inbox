Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264696AbTFQOIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264712AbTFQOIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:08:31 -0400
Received: from speedy.tutby.com ([195.209.41.194]:53154 "EHLO tut.by")
	by vger.kernel.org with ESMTP id S264696AbTFQOI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:08:29 -0400
Date: Tue, 17 Jun 2003 17:24:30 +0300
From: Igor Krasnoselski <iek@tut.by>
X-Mailer: The Bat! (v1.36) S/N F29DEE5D / Educational
Reply-To: Igor Krasnoselski <iek@tut.by>
X-Priority: 3 (Normal)
Message-ID: <11725.030617@tut.by>
To: Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org
Subject: Re[2]: Can't mount an ext3 partition - why?
In-reply-To: <20030617132856.GC24306@www.13thfloor.at>
References: <20030617132856.GC24306@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Herbert,

HP> what does an  fsck.ext3 -fpn  on the unmounted filesystem report?

I downloaded 2.4.21 sources, made "make oldconfig" and got a new
kernel with the same behavior :(

fsck.ext3 (e2fsck 1.27 8-Mar-2002)
run all 5 passes with no error reports under an old kernel, but under
new one it says:

fsck.ext3: No such file or directory while trying to open /dev/hdc1

The superblock could not be read....
etc.

I get further into this, and I find that I have no /dev/hdc1 (and
/dev/hdc, and /dev/hda too) at all! In place of them(?), I have

/dev/discs/~disc0/disc
/dev/discs/~disc0/part1
/dev/discs/~disc0/part2
/dev/discs/~disc0/part3
/dev/discs/~disc1/disc
/dev/discs/~disc1/part1

e2fsck gets them as previous /dev/hd+ args and reports no errors.
Is this a new feature since 2.4.18-3 kernel? Or maybe this all because
I add something strange to my config, like "/dev filesystem" ?

-- 
Best regards,
 Igor                            mailto:iek@tut.by
                                 mailto:u-com@mail.ru


