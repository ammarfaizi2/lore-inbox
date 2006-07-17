Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWGQDBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWGQDBU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 23:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWGQDBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 23:01:20 -0400
Received: from server.allaboutwebservices.com ([72.29.85.94]:28851 "EHLO
	server.allaboutwebservices.com") by vger.kernel.org with ESMTP
	id S932219AbWGQDBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 23:01:19 -0400
Message-ID: <44BAFDB7.9050203@calebgray.com>
Date: Sun, 16 Jul 2006 20:02:15 -0700
From: Caleb Gray <caleb@calebgray.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Reiser4 Inclusion
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.allaboutwebservices.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - calebgray.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Kernel Developers,

I would like to express my experiences with the reiser4 filesystem and
my reasons for its readiness to be officially included in the Linux kernel.

I have been putting together servers since 2001, all of which are still
operational and serving web sites reliably. The earliest servers I built
used ext3 for their primary filesystems. Overtime I realized that I
needed a faster filesystem for my servers' so I tried reiserfs. Those
servers were, in fact, more responsive but carried several headaches
into my life due to severe unreliability and so I was forced to convert
all of the reiserfs servers to ext3. It wasn't until two years ago that
I read about reiser4 and felt as though I should give the new reiser
filesystem a chance. After two years of reiser4 and five years of ext3,
I can attest to three things that reiser4 does just as well or better
than ext3: speed, responsiveness, and reliability. This is not to say
that reiser4 is _better_ than ext3, this is to simply say that it is as
production ready as ext3 is.

The reliability of reiser4 does _NOT_ compete with ext3 but it doesn't
falter from it either. For every time that I have to run fsck.ext3, I
have to run fsck.reiser4. Every time one of my servers crash, whether
it's ext3 or reiser4, I spend the exact same amount of time recovering
lost/broken files. And to note: the atomic file saving system that
reiser4 implements has never caused me any issues during file recovery.

Reiser4's responsiveness is undoubtedly at least twice as fast as ext3.
I have deployed two nearly identical servers in Florida (I live in
Washington state) but one difference: one uses ext3 and the other
reiser4. The ping time of the reiser4 server is (on average) 20ms faster
than the ext3 server. It has maintained this speed for the past two
years against the ext3 server even with aging hardware and bulking file
and directory structures. (Both of the filesystems have slowed down at a
similar pace for the duration of their lifetime [about 15ms].)

And finally reiser4's speed. I am constantly transferring files between
other servers, and hard drives. The servers are also (obviously) serving
data to the viewers of web sites, dealing with huge email queues (a few
gigabytes every few hours), and handling heavy cron jobs to tarball user
dirs from one drive to another. The reiser4 and ext3 servers deal with
relatively the same amount of data to compress (~190GiB each), and the
reiser4 is and always has been the first to finish. Not only finish
first though, it generally finishes about 45 minutes before the ext3
server. (You can ignore the idea that it's probably the CPUs that can't
handle the compression not the filesystems, because while the backup is
running on both dual core processors the load never surpasses 45%; the
bottleneck comes down to the throughput efficiency of data between drives.)

The purpose of this email is not to bash ext3. As I have said I have a
five year old ext3 server that runs great, and I intend to keep it that
way. The reason that I have sent this is to present real life situations
where reiser4 is reliable, fast, usable, and production ready. It is
both realistic and reasonable to say that reiser4 is prepared to be
officially supported in the Linux kernel.

Please consider the fact that I have patched my servers' kernels time
and time again, with all kinds of patches, and I have never once had an
issue with the reiser4 patched kernels. Thank you for taking time away
from development to read this email (I'm a programmer too), I know how
it is.

Sincerely,
Caleb Gray
