Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270031AbRIOOuR>; Sat, 15 Sep 2001 10:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270224AbRIOOuH>; Sat, 15 Sep 2001 10:50:07 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:5022 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S270031AbRIOOt6>; Sat, 15 Sep 2001 10:49:58 -0400
Message-ID: <3BA36A72.20702@korseby.net>
Date: Sat, 15 Sep 2001 16:49:22 +0200
From: Kristian <kristian@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>,
        David Weinehall <tao@acc.umu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext2fs corruption again
In-Reply-To: <3BA33818.8030503@korseby.net> <20010915122113.A24561@grobbebol.xs4all.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roeland Th. Jansen wrote:
> not that I say IBM's drive is bad, it's just a thought.

They are bad if it's hardware-related. The big one is manufactured in Hungary, 
the other one in Thaiwan.

The error occured again.

I post the new errors. Maybe you can see any structure in it.

Sep 15 16:16:23 adlib kernel: EXT2-fs error (device ide0(3,5)): 
ext2_free_blocks: bit already cleared for block (5412-5427)

e2fsck reported the following on that device (hda5):

++ entries are new with this check
-- entries only appeared earlier

Duplicate/bad bock(s) in inode:  97: 643 +644+
Duplicate/bad bock(s) in inode:  98: +647+
Duplicate/bad bock(s) in inode:  99: +648+
Duplicate/bad bock(s) in inode: 100: 649
Duplicate/bad bock(s) in inode: 101: 650 651
Duplicate/bad bock(s) in inode: 102: 652
Duplicate/bad bock(s) in inode: 103: 653 656 +657+
Duplicate/bad bock(s) in inode: 104: +658+ 659 660
Duplicate/bad bock(s) in inode: 105: 661 662 663 664 665 666
Duplicate/bad bock(s) in inode: 106: 667 -668-
Duplicate/bad bock(s) in inode: 107: 669 -671-
-Duplicate/bad bock(s) in inode: 108: 672 673 674-
-Duplicate/bad bock(s) in inode: 110: 678-

767011: 647 648 649 650 651 652 653 654 671
832166: 655 656 657 658 659 660 661 662
832170: 643 644
832178: 663 664 665 666 667

832178 is /var/log/boot.log
832170 is /var/log/wtmp
832166 is /var/log/messages
767011 is /home/tisi/syslog

Only syslog related files are concerned.

syslog is configured that it will accept logs from other machines. Maybe there's 
a possibility that these strange errors were caused by the network-card or 
-driver ? I own an eepro100. Just a thought...

These errors occured since 2.4.5 that's why I think it's software-related.

I'll try to use 'hdparm -d1 -X33 /dev/hda' and other modes to see if it occurs 
again. But testing could take some time. It appears ~~ every second day.

Kristian

·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                          :: http://www.korseby.net
                          :: http://www.tomlab.de
kristian@korseby.net ....::

