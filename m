Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSLaIYN>; Tue, 31 Dec 2002 03:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262528AbSLaIYN>; Tue, 31 Dec 2002 03:24:13 -0500
Received: from softers.net ([213.139.168.106]:3712 "EHLO mail.softers.net")
	by vger.kernel.org with ESMTP id <S261368AbSLaIYN>;
	Tue, 31 Dec 2002 03:24:13 -0500
Message-ID: <3E11562D.421CAE73@softers.net>
Date: Tue, 31 Dec 2002 10:32:45 +0200
From: Jarmo =?iso-8859-1?Q?J=E4rvenp=E4=E4?= 
	<Jarmo.Jarvenpaa@softers.net>
Organization: Softers Oy
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Ide problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've been buggered with multiple lockups of an med/heavily loaded 2.4.19
(also rc-series) and same server with 2.4.20. Machine is running
normally for a week or two, then IDE light is lit and processes are
stuck in D state (if any disk activity is required -> freezed process).
I'm using (ide-) software raid 1 and 5, tested with raid 1 alone and
same lockup-problem appears.

So, IDE-light is continuously lit but the disks are not reading nor
writing. Emergency sync nor the unmount is working. I'm guessing the
IDE-code (eh, raid too) might be cause of this.
- No OOM situation have been observed, there's been lots of free ram at
the time of each lockup.
- Processes with no disk activity are not affected (for examples vmstat
1 runs ok if started before lockup)

Currently I'm thinking of falling back to .18 with hopes of no more
problems.

Any similar experiences?


Regards,
Jarmo


PS. An extremely useful feature would be a method to freeze raid resync
until fsck is finished. Now, when both are running at the same time
server's boot speed is miserable.
