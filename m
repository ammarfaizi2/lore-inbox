Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130657AbQLJX7O>; Sun, 10 Dec 2000 18:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130891AbQLJX7D>; Sun, 10 Dec 2000 18:59:03 -0500
Received: from w051.z209031005.sjc-ca.dsl.cnc.net ([209.31.5.51]:34060 "EHLO
	fyrk.aeinet.com") by vger.kernel.org with ESMTP id <S130657AbQLJX66>;
	Sun, 10 Dec 2000 18:58:58 -0500
From: Johnathan Corgan <jcorgan@atlas.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Difficult to diagnose oops in 2.2.17, details at www.aeinet.com/oops
Date: Sun, 10 Dec 2000 15:28:18 -0800
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00121015281800.06546@atlas>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please cc: me directly if you so choose, I am not subscribed to l-k at the 
moment. Thanks.  Otherwise, I'll follow the thread in a l-k archive.)

All,

I'd like to enlist your help in diagnosing a series of oopsen over the last 
eight weeks. I didn't start tracking the problem in detail until a week ago, 
but you can now find the log files, ksymoops output, SysRq dumps, and other 
files at:

http://www.aeinet.com/oops

Basically, the system is a stock Debian 2.2 (potato) install on an Intel 
system, with a custom compiled kernel. The motherboard is a dual-cpu Intel 
N440BX server board with single PIII (katmai) 500 cpu, 256 MB RAM, and is 
very lightly loaded most of the time.

It had been stable for approximately nine months on 2.2.14, then began to 
exhibit a variety of strange oops and crashes about eight weeks ago. 
Generally, the oops would result in a hard system lock up, where only a reset 
would return the box to normal. Some of these oops made it into 
/var/log/messages, and ksymoops was run on that. The output is one of the 
links at the URL above. The average uptime at this point was about an hour or 
two, though sometimes it was only five minutes.

My first guess was hardware, specifically memory.  Running memcheck86 on the 
system found serious faults, so the memory was replaced with a new module 
that passed memcheck86 with flying colors. The result was that the system 
would stay up approximately one or two days at a time, but the oops and 
lockups were still occurring.

Since it was taking about 15 minutes to reboot, I installed and converted to 
reiserfs (3.5.57), and upgraded to 2.2.17 at the same time.  The kernel is 
now 2.2.17 + crypto (10) + reiserfs (3.5.57) + badram (3.3). No change in the 
symptoms happened, and I was resetting the system manually every day or so.

Fast forward to about a week ago, when I decided that I should seek community 
help. As an incentive, I'll ship one six-pack of beer anywhere in the world 
to the first person who solves this problem permanently. Brand of beer is 
negotiable--but I only have access to cheap American beer :)

See the web log for the (unsuccessful) efforts taken so far suggested by the 
helpful people at #linpeople and #kernelnewbies on irc.debian.org.

I still suspect it's hardware, though I have no idea what it might be now. 
Christmas break brings a new system to replace it, so it will be moot by 
then, but I'm still determined to get to the bottom of it anyway.

Thanks for your time.

Johnathan Corgan
Atlas Enterprises Internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
