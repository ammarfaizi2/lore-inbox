Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276457AbRI2Hzk>; Sat, 29 Sep 2001 03:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276458AbRI2HzV>; Sat, 29 Sep 2001 03:55:21 -0400
Received: from mailg.telia.com ([194.22.194.26]:15828 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S276457AbRI2HzQ>;
	Sat, 29 Sep 2001 03:55:16 -0400
Message-ID: <3BB57E77.4CDFF5D0@energymech.net>
Date: Sat, 29 Sep 2001 09:55:35 +0200
From: proton <proton@energymech.net>
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.2.19 i686)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Makefile gcc -o /dev/null: the dissapearing of /dev/null
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this a long time ago in the Linux kernel
makefiles, I thought someone would have figured it
out by now tho.

The `gcc -o /dev/null' is a really neat way of
testing if gcc works or not.

Unfortunatly it doesnt work that well if you're root.

You see, gcc uses unlink(). /dev/null doesnt take
kindly to that kind of treatment...

Ofcourse, you cant unlink /dev/null unless you are root.

In any case, the `gcc -o /dev/null' test cases probably
need to go away.

I've seen this in linux/arch/i386/Makefile for 2.4.10,
it probably exists in all previous versions as well as
in other Makefiles.

Happy kernel hacking!

/proton
ps. any replies [read: flames] would do well being CC'd
to me since I dont subscribe to linux-kernel :)
[ http://www.energymech.net/users/proton/ ]
