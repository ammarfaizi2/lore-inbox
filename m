Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSGZEw0>; Fri, 26 Jul 2002 00:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSGZEvt>; Fri, 26 Jul 2002 00:51:49 -0400
Received: from [195.63.194.11] ([195.63.194.11]:2054 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S316824AbSGZEvY>;
	Fri, 26 Jul 2002 00:51:24 -0400
Message-ID: <3D4098FC.3080209@evision.ag>
Date: Fri, 26 Jul 2002 02:34:04 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, martin@dalecki.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Safety of IRQ during i/o
References: <Pine.LNX.3.96.1020725071201.10698A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> On 25 Jul 2002, Alan Cox wrote:
> 
> 
>>There are also some older systems where if the block transfer of the IDE
>>data didn't keep up with the controller instead of handshaking properly
>>it kind of dribbled random numbers onto the disk.
>>
>>Unless anyone knows of PCI era devices with this problem I would be
>>inclined to agree that we should default to IRQ unmasking in the 2.5 IDE
>>code if the IDE controller is PCI.
> 
> 
> Certainly if the controller is running in DMA mode. If running in PIO mode
> I would think you could still have a problem if the transfer was stopped
> mid-block. Perhaps I'm paranoid, is that a "can't happen" now?

Please note that with the advent of on target device caching this is
neraly impossible unless you chook the cabling - which is of course
something we can't prevent.

>>For old ISA/VLB controllers its safer left as is, and nobody running a
>>machine like that can realistically expect good performance without hand
>>tuning stuff anyway
> 
> 
> I would think the guts of PIO block transfer would have to be protected
> anyway, but that's a very small part of the code. 


