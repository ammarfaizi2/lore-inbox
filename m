Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTJ0TZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 14:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTJ0TZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 14:25:29 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:4648 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S263486AbTJ0TZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 14:25:22 -0500
Message-ID: <3F9D7120.1020207@planet.nl>
Date: Mon, 27 Oct 2003 20:25:20 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031025
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Heavy disk activity without apperant reason (added more info)
References: <3F9BC429.6060608@planet.nl> <3F9D0BBB.9080600@aitel.hist.no>
In-Reply-To: <3F9D0BBB.9080600@aitel.hist.no>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Helge,

I had the very interesting disk activity again. No serious activity was 
happening. I've tried to make some sense of the 2 output commands you've 
asked, but they make not much sense. Sorry :-( that I need to ask so 
much help on this (bug) report.

This is the output of vmstat

procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
id wa
 1  0      0 122124  37396 238892    0    0     0   100 1073  1246 98  
2  0  0
 1  0      0 121996  37396 239020    0    0   128     0 1079  1068 100  
0  0  0
 1  0      0 121988  37396 239020    0    0     0     0 1109  1266 99  
1  0  0
 1  0      0 121860  37396 239020    0    0     0     0 1124  1393 97  
3  0  0
 1  0      0 121924  37396 239020    0    0     0     0 1143  1220 98  
2  0  0
 2  0      0 121924  37416 239020    0    0     0    32 1081  1154 99  
1  0  0
 2  0      0 121924  37416 239020    0    0     0     0 1061  1096 99  
1  0  0
 1  0      0 121796  37448 239148    0    0   128    36 1063  1104 99  
1  0  0
 1  0      0 121732  37448 239152    0    0     0     0 1147  1471 98  
2  0  0
 2  0      0 121732  37448 239152    0    0     0     0 1118  1330 99  
1  0  0
 1  2      0 121212  37484 239160    0    0     0   180 1264  1631 96  
4  0  0
 1  1      0 121148  37484 239160    0    0     0   158 1305  1540 95  
5  0  0
 1  1      0 121148  37484 239164    0    0     0   166 1300  1678 95  
5  0  0
 1  1      0 121148  37484 239172    0    0     0   199 1315  6863 93  
7  0  0
 1  2      0 121020  37484 239316    0    0   128   217 1303  2197 94  
6  0  0
 1  2      0 121020  37500 239320    0    0     0   213 1300  7326 91  
9  0  0
 1  1      0 120956  37500 239328    0    0     0   225 1352  1842 93  
7  0  0
 3  1      0 120948  37500 239336    0    0     0   219 1346  1656 94  
6  0  0
 1  1      0 120772  37500 239348    0    0     0   228 1351  1678 94  
6  0  0
 2  1      0 120948  37500 239356    0    0     0   198 1252  1476 96  
4  0  0
 1  0      0 121204  37500 239484    0    0   128    40 1122  1162 98  
2  0  0

and this is top

top - 20:17:06 up  1:15,  1 user,  load average: 1.63, 1.26, 1.19
Tasks:  77 total,   3 running,  74 sleeping,   0 stopped,   0 zombie
Cpu(s):  4.0% us,  2.0% sy, 93.1% ni,  0.0% id,  0.0% wa,  1.0% hi,  0.0% si
Mem:    515692k total,   394488k used,   121204k free,    37500k buffers
Swap:   136512k total,        0k used,   136512k free,   239484k cached
                                                                                

  PID USER      PR      NI  VIRT      RES      SHR S %CPU %MEM    TIME+  
COMMAND
  118     root      39      19      1120      584     1072 R 94.4  0.1  
68:55.07 dnetc
  225     root      16       0     73620      20m      54m R  1.0  4.2   
1:15.36 X
  263     stef      15       0     21116     6720     7412 S  1.0  1.3   
0:05.12 xmms
  303     stef      15       0     22948      14m      14m S  1.0  3.0   
0:14.47 gnome-terminal
  318     stef      15       0     66528      49m      26m S  1.0  9.9   
3:56.12 mozilla-bin
  667     stef      16       0      1912     1028     1756 R  1.0  0.2   
0:09.34 top
    1     root      16       0       420      216      388 S  0.0  0.0   
0:06.29 init
    2     root      34      19     0    0        0 S      0.0  0.0   
0:00.00 ksoftirqd/0
    3     root       5     -10      0    0        0 S      0.0  0.0   
0:00.02 events/0
    4     root       5     -10      0    0        0 S      0.0  0.0   
0:00.01 kblockd/0
    5     root      15       0      0    0        0 S      0.0  0.0   
0:00.03 kapmd
    6     root      25       0      0    0        0 S      0.0  0.0   
0:00.00 pdflush
    7     root      15       0      0    0        0 S      0.0  0.0   
0:00.28 pdflush
    8     root      25       0      0    0        0 S      0.0  0.0   
0:00.00 kswapd0
    9     root      10     -10     0    0        0 S      0.0  0.0   
0:00.00 aio/0
   10 root      21           0     0    0        0 S      0.0  0.0   
0:00.00 scsi_eh_0
   11 root      15           0     0    0        0 S      0.0  0.0   
0:00.00 ahc_dv_0

Best regards,

Stef

Helge Hafting wrote:

> Stef van der Made wrote:
>
>>
>> On my AMD athlon system with 512MB memory I sometimes get a lot of 
>> disk activity the activity normaly lasts for about 10 seconds and 
>> after that the disk stays relativily quiet as expected with the load 
>> on the system. When I look into top I don't see any programs that 
>> could explain the disk activity. The system is in most cases not 
>> using any swap.
>>
> Try finding out what is causing this.
> Have a "vmstat 1" running.  Break it after this
> disk activity starts.  You should be able to
> see wether it is normal io or swap.
>
> Also have a "top -d 1" running.  A normal
> process issuing lots of io will probably
> show up here too.  "ps aux" during
> the activity might also be a good idea.
>
> Note that such behaviour isn't necessarily unusual.
> Perhaps cron started something that needed lots
> of reads to start?  Perhaps you got a bunch of emails?
> Email software often use synchronous writes, so they won't
> loose any of your mail even in case of a crash.
> This synchronous io makes for _lots_ of disk seeking.
> Email filters (for spam and other purposes) may make this even worse, 
> with email messages being written synchronously several times.
> If you use "fetchmail" started by cron - see if these disk bursts
> correspond with mail fetching.
>
> Helge Hafting
>
>

