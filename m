Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbTH2K0N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbTH2K0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:26:13 -0400
Received: from [212.34.184.41] ([212.34.184.41]:9389 "EHLO mail.hometree.net")
	by vger.kernel.org with ESMTP id S264500AbTH2K0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:26:12 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: usb-storage: how to ruin your hardware(?)
Date: Fri, 29 Aug 2003 10:25:50 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bin9ne$u7n$1@tangens.hometree.net>
References: <20030828154454.A2343@pclin040.win.tue.nl> <200308281618.h7SGIMMp014455@wildsau.idv.uni.linz.at>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1062152750 30967 212.34.184.4 (29 Aug 2003 10:25:50 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Fri, 29 Aug 2003 10:25:50 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at> writes:

>> On Thu, Aug 28, 2003 at 04:59:14AM +0200, H.Rosmanith (Kernel Mailing List) wrote:
>> 
>> > the contradiction to this is that the flashdisk can be used
>> > in a "partition-less" state where it is possible to use the
>> > whole device at one: "mke2fs /dev/sdb". you have to use the
>> > vendor formating-tool to make the flashdisk look like an USB_FDD
>> > device. but even in USB_HDD mode with partitions, the partitions
>> > still look strange, not ending on cylinder boundaries and so on.
>> 
>> I have seen several posts from you, but all in this vague, almost
>> information-free style.

>the information is vague, because I don't exactly know how I manage
>to stop the drive working.

Back it up:

dd if=/dev/sda of=/tmp/save bs=512 count=<number of blocks on your flash disk>

Clean it:

dd if=/dev/zero of=/dev/sda bs=512 count=100

See what happens. If it does not work any longer, we can take a peek
at the backup (especially the first few sectors).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

"Dominate!! Dominate!! Eat your young and aggregate! I have grotty silicon!" 
      -- AOL CD when played backwards  (User Friendly - 200-10-15)
