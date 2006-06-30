Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWF3Fpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWF3Fpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 01:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWF3Fpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 01:45:54 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:40142 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id S1751131AbWF3Fpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 01:45:52 -0400
Mime-Version: 1.0
Message-Id: <a06230917c0ca677203fd@[129.98.90.227]>
Date: Fri, 30 Jun 2006 01:44:59 -0400
To: drbd-user@linbit.com
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: Kernel 2.67.17.1 is hanging I/O under AMD64 [Was Re: Kernel
 2.6.17-rc5 under amd64 may be hanging I/O]
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem,at least I think it's the same problem, also occurs in 
kernel 2.6.17.1.

The relevant output has been posted online at
http://www.kennedy.aecom.yu.edu/misc/drbdstall2.htm

>
>/ 2006-06-08 20:34:10 -0400
>\ Maurice Volaski:
>>  It appears that kernel 2.6.17-rc5 under amd64 may be hanging I/O
>>  processes spontaneously at random.
>>
>>  Our setup here uses drbd (ver. 0.7.19), which is a network RAID kernel
>>  module, and initially I was fscking (ext3) filesystems, which are on
>>  drbd devices, and the fsck just stopped spontaneously on the two of
>  > them.
>>
>>  Today, I tried copying a directory on the command line with cp -a on
>>  this computer (on a drbd-managed device) and then in mid-copy I tried
>>  to abort the process with control-C. It did not abort. I tried killing
>>  it with kill and then with kill -9. It turns out that the process had
>>  died, but is still left in ps.
>>
>>  Just by happenstance,
>>
>>  Anyway, I tried bringing down the peer and bringing it back up and it
>>  stalled.
>>
>  > I also had an emerge sync (i.e., the Gentoo update mechanism) going
>>  and it too got stuck, but it doesn't, or at least shouldn't affect
>>  drbd disks, implying this is not a drbd bug, but a kernel bug.
>>
>
>well. it says below that emerge hangs is drbd_al_begin_io, so it is at
>least drbd related, too.
>
>>  >* what are the numbers in /proc/drbd
>>
>>  This is how it appears long after the copy hang and I stopped and just
>>  restarted drbd on the peer. The output from then hanging computer:
>
>thanks, that might help in debugging things.
>I'll have a look, maybe I can find something in there.


-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
