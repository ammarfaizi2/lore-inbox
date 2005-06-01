Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVFALNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVFALNa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 07:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVFALLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 07:11:40 -0400
Received: from relay03.pair.com ([209.68.5.17]:20754 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S261259AbVFALK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 07:10:56 -0400
X-pair-Authenticated: 24.241.238.70
Message-ID: <429D97BE.4060905@cybsft.com>
Date: Wed, 01 Jun 2005 06:10:54 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Serge Noiraud <serge.noiraud@bull.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RT : Large transfert with 2.6.12rc5	+	realtime-preempt-2.6.12-rc5-V0.7.47-15
References: <1117552050.19367.63.camel@ibiza.btsn.frna.bull.fr>	 <429C8E4E.4010608@cybsft.com> <1117609093.5580.6.camel@ibiza.btsn.frna.bull.fr>
In-Reply-To: <1117609093.5580.6.camel@ibiza.btsn.frna.bull.fr>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge Noiraud wrote:
> Le mar 31/05/2005 à 18:18, K.R. Foley a écrit :
> 
>>Serge Noiraud wrote:
>>
>>>I had the same problem with rc4+47-07, rc5+47-10,47-13
>>>I reproduce this problem with a tg3 driver and with e1000 driver.
>>>So I think it's not a driver problem.
>>>
>>>I try to copy an iso image from this machine to another one by scp.
>>>after 35 to 45MB, the copy become stalled with no more transfert.
>>>We can ping the target machine, all apparently is OK except the scp
>>>which finish with timeout.
>>>With ftp, the stalled state is about 100MB.
>>>If I reboot with a standard kernel ( without RT ), no problem.
>>>
>>>Perhaps there is a progress, in 47-15, the size is now 135-140MB
>>>
>>>On this machine, we have an ide disk.
>>>I have setup : hdparm 
>>>-sh-2.05b# hdparm /dev/hda
>>>
>>>/dev/hda:
>>> multcount    = 16 (on)
>>> IO_support   =  3 (32-bit w/sync)
>>> unmaskirq    =  1 (on)
>>> using_dma    =  1 (on)
>>> keepsettings =  0 (off)
>>> readonly     =  0 (off)
>>> readahead    = 256 (on)
>>> geometry     = 65535/16/63, sectors = 78165360, start = 0
>>>
>>
>>Hi,
>>
>>I am not sure what might be causing this problem for you. I just tried 
>>to reproduce this on one of my systems but could not (scsi not ide). The 
>>first time it copied 450MB before the remote system ran out of space. 
>>After cleaning up a bit I got the whole 630MB without a hitch. Do you 
>>have the RT patch on both systems or just on the originating system? In 
>>my case its the latter. There is
> 
> 
> The scp or ftp start on a RT machine.
> The destination is an RT or Non RT machine, the problem is the same.
> It's not a space problem, I have 4GB available on the destination path.
> I can reproduce the phenomena at each try.
> If I <CTRL C> the scp when it is stalled then relaunch the scp command, the transfert restart without problem.
> I'm trying to trace this problem but I don't know how to do this.
> Has someone one method ?
> 
> 

Do any of your logs provide any clues? Does this happen with just
2.6.12-rc5 and no rt-preempt patch? Does ifconfig provide any clues? How
about netstat -a? What is the state of the connection?

-- 
   kr
