Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSCLNPV>; Tue, 12 Mar 2002 08:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311177AbSCLNPN>; Tue, 12 Mar 2002 08:15:13 -0500
Received: from [194.228.240.11] ([194.228.240.11]:41646 "EHLO sakal.vgd.cz")
	by vger.kernel.org with ESMTP id <S311024AbSCLNO7>;
	Tue, 12 Mar 2002 08:14:59 -0500
Subject: 2.5.6 Swap reporting incorect values (was: 2.5.6 Swap weirdness)
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFD2E4928E.ADAFE981-ONC1256B7A.0048968C@vgd.cz>
From: Petr.Titera@whitesoft.cz
Date: Tue, 12 Mar 2002 14:14:31 +0100
X-MIMETrack: Serialize by Router on Sakal/SRV/SOCO/CZ(Release 5.0.8 |June 18, 2001) at
 03/12/2002 02:14:57 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not a issue. I checked free and it reads values from /proc/meminfo

[owl@chudak owl]$ cat /proc/swaps
Filename                                Type            Size    Used
Priority
/dev/hda5                               partition       88664   148     -1
[owl@chudak owl]$ cat /proc/meminfo
MemTotal:        62968 kB
MemFree:          9324 kB
MemShared:           0 kB
Buffers:          7396 kB
Cached:          23608 kB
SwapCached:        148 kB
Active:          14908 kB
Inactive:        31604 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        62968 kB
LowFree:          9324 kB
SwapTotal:       88812 kB
SwapFree:        88664 kB
[owl@chudak owl]$



                                                                                              
                    Mark Hahn                                                                 
                    <hahn@physics.mc       To:     <Petr.Titera@whitesoft.cz>                 
                    master.ca>             cc:                                                
                                           Fax to:                                            
                    10.03.2002 18:22       Subject:     Re: 2.5.6 Swap weirdness              
                                                                                              
                                                                                              




>      in linux kernel 2.5.6 swap statistics are displayed incorrectly.
Used
> space is added to total swap size and not subtracted from free space. See
> attached output

don't you merely mean that 'free' is buggy?  not a kernel issue.



>
>
> [root@nevskij proc]# free
>              total       used       free     shared    buffers     cached
> Mem:        257348     159748      97600          0       9328      41004
> -/+ buffers/cache:     109416     147932
> Swap:       152800      24320     128480
> [root@nevskij proc]# cat /proc/swaps
> Filename                                Type            Size    Used
> Priority
> /dev/hda5                               partition       128480  24316
-1
> [root@nevskij proc]#
>
> Petr Titera
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--
operator may differ from spokesperson.               hahn@mcmaster.ca
                                              http://hahn.mcmaster.ca/~hahn




