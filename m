Return-Path: <linux-kernel-owner+w=401wt.eu-S1751425AbXAVGpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbXAVGpa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 01:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbXAVGpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 01:45:30 -0500
Received: from scrye.com ([216.17.180.1]:48016 "EHLO mail.scrye.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425AbXAVGp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 01:45:29 -0500
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
From: Tony Foiani <tkil@scrye.com>
Reply-To: Tony Foiani <tkil@scrye.com>
X-Attribution: Tkil
CC: jengelh@linux01.gwdg.de (Jan Engelhardt),
       David Schwartz <davids@webmaster.com>,
       Leon Woestenberg <leon.woestenberg@gmail.com>,
       linux-kernel@vger.kernel.org
References: <c384c5ea0701201007t4e637b9eh133101286ce5598d@mail.gmail.com> <MDEHLPKNGKAHNMBLJOLKEEKNBAAC.davids@webmaster.com> <gzm8d1bv1.fsf@brand.scrye.com> <Pine.LNX.4.61.0701212208080.29213@yvahk01.tjqt.qr>
Date: Sun, 21 Jan 2007 23:45:28 -0700
In-Reply-To: <Pine.LNX.4.61.0701212208080.29213@yvahk01.tjqt.qr> (Jan Engelhardt's message of "Sun, 21 Jan 2007 22:12:55 +0100 (MET)")
Message-ID: <gac0blfuf.fsf@brand.scrye.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> "Tony" == Tony Foiani <tkil@scrye.com> writes:

Tony> How fast is your Ethernet port?  100Mbps or 95.37Mbps?

>>>>> "Jan" == Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

Jan> Same lie like with harddrives. It's around 80, not 100.  But it
Jan> depends on how you look at it. 80 for Layer3, possibly a little
Jan> more for Layer2/1.

No, it's not the same lie.  The physical media -- as presented to the
next higher layer -- really has 100Mbps capability.  Likewise, the
"physical media" of a hard drive (as seen outside the controller on
the disk) really is 500GB/465GiB (or whatever). [1]

The overhead caused by Ethernet frames (level 2) and then IP packets
(level 3) and then TCP or UDP (level 4) are more closely related to
the losses you get on filesystem overhead (superblock, inodes,
directories) and "slack" in block-allocated systems (having to round
sizes up to the next 512 or whatever). [2]

The problem is that a drive labelled "500GB" on its packaging is
displayed as "465GB" on the computer.  The fix is to have the computer
display either "500GB" or "465GiB".

t.

[1] SFAIK, what's really on hard drive platters anymore is something
    much closer to "symbols", not just 1s and 0s.  In the same way
    that "baud" is "symbols per second", the actual thingies on the
    platters are symbols, and it's up to the drive electronics to make
    sense of them.

[2] Level numbers from: http://en.wikipedia.org/wiki/TCP/IP_model

