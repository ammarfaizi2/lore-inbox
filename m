Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWFIPIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWFIPIY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 11:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWFIPIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 11:08:24 -0400
Received: from ev1s-67-15-60-3.ev1servers.net ([67.15.60.3]:55007 "EHLO
	mail.aftek.com") by vger.kernel.org with ESMTP id S1030202AbWFIPIX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 11:08:23 -0400
X-Antivirus-MYDOMAIN-Mail-From: abum@aftek.com via plain.ev1servers.net
X-Antivirus-MYDOMAIN: 1.22-st-qms (Clear:RC:0(59.95.1.167):SA:0(-102.4/1.7):. Processed in 3.538675 secs Process 20812)
From: "Abu M. Muttalib" <abum@aftek.com>
To: <linux-arm-kernel@lists.arm.linux.org.uk>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: FW: significance of process "events/0"
Date: Fri, 9 Jun 2006 20:45:23 +0530
Message-ID: <BKEKJNIHLJDCFGDBOHGMIEKNCOAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abu,

Oops, I forgot to CC the list. That's done now.
I suggest you to resend your reply to the list...

Hope someone has a clue...

    :-)

    Michael.
> Hi Mick,
>
> Thats exactly I want to know. My target after this causes an OOM.
>
> ~Abu.
>
> -----Original Message-----
> From: Michael Opdenacker [mailto:michael-lists@free-electrons.com]
> Sent: Friday, June 09, 2006 7:46 PM
> To: Abu M. Muttalib
> Subject: Re: significance of process "events/0"
>
>
> Hi Abu,
>   
>> While running few of the application on target board, running kernel
>>     
> 2.6.13
>   
>> compiled for ARM architecture, I get the following ps listings:
>>
>>   PID  Uid     VmSize Stat Command
>>     1 yoku        528 S   init [3]
>>     2 yoku            SWN [ksoftirqd/0]
>>     3 yoku            SW< [events/0]
>>     4 yoku            SW< [khelper]
>>     5 yoku            SW< [kthread]
>>    18 yoku            SW< [kblockd/0]
>>    43 yoku            SW  [pdflush]
>>    44 yoku            SW  [pdflush]
>>    46 yoku            SW< [aio/0]
>>    45 yoku            SW  [kswapd0]
>>   634 yoku            SW  [mtdblockd]
>>   664 yoku            SWN [jffs2_gcd_mtd1]
>>   773 yoku            SW  [affixd]
>>   800 yoku        540 S   disc_mgr
>>   807 yoku        764 S   btsrv --managekey --nomanagepin
>>   808 yoku        424 S   BT_ActivityMgr
>>   809 yoku        256 S   /root/pwr_key_monitor
>>   839 yoku        840 S   btsdpd -d
>>   863 yoku       1316 S   /bin/sh
>>   879 yoku       1416 S   /root/Angelia
>>   889 yoku       1416 S   /root/Angelia
>>   890 yoku       1416 S   /root/Angelia
>>   891 yoku       1416 S   /root/Angelia
>>   898 yoku       1416 S   /root/Angelia
>>   899 yoku       1416 S   /root/Angelia
>>   900 yoku       1416 S   /root/Angelia
>>   901 yoku       1416 S   /root/Angelia
>>   902 yoku       1416 S < /root/Angelia
>>  1101 yoku            Z < [events/0]
>>  1103 yoku            Z < [events/0]
>>  1178 yoku            Z < [events/0]
>>  1180 yoku            Z < [events/0]
>>  1255 yoku            Z < [events/0]
>>  1257 yoku            Z < [events/0]
>>  1332 yoku            Z < [events/0]
>>  1334 yoku            Z < [events/0]
>>  1411 yoku            Z < [events/0]
>>  1413 yoku            Z < [events/0]
>>  1488 yoku            Z < [events/0]
>>  1490 yoku            Z < [events/0]
>>  1565 yoku            Z < [events/0]
>>  1567 yoku            Z < [events/0]
>>  1642 yoku            Z < [events/0]
>>  1644 yoku            Z < [events/0]
>>  1719 yoku            Z < [events/0]
>>  1721 yoku            Z < [events/0]
>>  1796 yoku            Z < [events/0]
>>  1798 yoku            Z < [events/0]
>>  1873 yoku            Z < [events/0]
>>  1875 yoku            Z < [events/0]
>>  1950 yoku            Z < [events/0]
>>  1952 yoku            Z < [events/0]
>>  2027 yoku            Z < [events/0]
>>  2029 yoku            Z < [events/0]
>>  2104 yoku            Z < [events/0]
>>  2106 yoku            Z < [events/0]
>>  2181 yoku            Z < [events/0]
>>  2183 yoku            Z < [events/0]
>>  2258 yoku            Z < [events/0]
>>  2260 yoku            Z < [events/0]
>>  2337 yoku            Z < [events/0]
>>  2339 yoku            Z < [events/0]
>>
>> I fail to understand what is the relevance of process "events/0"?
>>
>>     
> [events/n] is a kernel thread implementing the default work queue on CPU
> #n , which kernel code can use to run code in process context. See
> http://www.linuxjournal.com/article/6916 for more details.
>
> I just wonder why ps shows many such [events/0]  processes (in Zombie
> state), instead of just one (like on my GNU/Linux PC, for example)...
>
> Cheers,
>
>     Michael.
>
> --
> Michael Opdenacker, Free Electrons
> Free Embedded Linux Training Materials
> on http://free-electrons.com/training
> (More than 1000 pages!)
>
>
>
>   


-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training
(More than 1000 pages!)


