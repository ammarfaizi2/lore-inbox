Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311193AbSCSNSJ>; Tue, 19 Mar 2002 08:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311194AbSCSNR5>; Tue, 19 Mar 2002 08:17:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62729 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311193AbSCSNRr>; Tue, 19 Mar 2002 08:17:47 -0500
Subject: Re: Linux 2.4.19-pre3-ac1
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Tue, 19 Mar 2002 13:32:13 +0000 (GMT)
Cc: MrChuoi@yahoo.com (MrChuoi), linux-kernel@vger.kernel.org (Linux Kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.44.0203190753140.25412-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Mar 19, 2002 07:54:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nJin-0007iU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> actually been *allocated* as per requests, but not necesserily in use? 
> This one is my home box, looks a bit crazy don't you think? The box has 

Yes

> about ~120 processes right now, heavy X session (2000x2000@32 virtual, 
> KDE2 with lots of eye candy), two kernel builds in the background and 
> cdrecord. 

I'm chasing a leak or two somewhere. One common theme seems to be KDE so
my guess is there is something like an mprotect/mremap/shared page path that
isnt correctly accounted and kde triggers more than most other stuff (eg
because of the strange way KDE execs new processes). 

Last night I added some validator code for the non shmfs cases to see if
I can find it. 
