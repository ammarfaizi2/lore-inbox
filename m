Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273371AbRIRK4A>; Tue, 18 Sep 2001 06:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273367AbRIRKzv>; Tue, 18 Sep 2001 06:55:51 -0400
Received: from unthought.net ([212.97.129.24]:7638 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S273366AbRIRKzm>;
	Tue, 18 Sep 2001 06:55:42 -0400
Date: Tue, 18 Sep 2001 12:56:05 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: bdflush and postgres stuck in D state
Message-ID: <20010918125605.F29908@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a machine here with (RedHat 7.0 plus official updates plus kernel.org
kernel):

[osprey:joe] $ uname -a
Linux osprey 2.4.7 #1 Sat Jul 21 21:50:21 CEST 2001 i686 unknown

[osprey:joe] $ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-85)

/ is mounted on a four disk (software) RAID-5, the same four disks are used for
a RAID-1 but the fs on there is mounted somewhere irrelevant for this post.

All fs are ext2.  The machine is not heavily loaded at all.  What made me
wonder was, that the load on the machine was '1' some days ago, today it was
'2'.  The machine usually has 90%+ CPU idle, and doesn't use the disks very
much.  Looking at 'ps' shows:

[osprey:joe] $ ps ax|grep ' D'
    6 ?        DW     0:26 [bdflush]
10023 ?        D      0:00 /usr/bin/postmaster -D /var/lib/pgsql/data

But there is *NO* disk activity. The processes are just stuck.   As far as
I can see, there's nothing even remotely suspicious in dmesg.

Any ideas ?    I can dig further before rebooting and trying 2.4.9
if someone tells me where to dig...

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
