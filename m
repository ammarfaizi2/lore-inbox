Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293659AbSCPCHZ>; Fri, 15 Mar 2002 21:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293661AbSCPCHP>; Fri, 15 Mar 2002 21:07:15 -0500
Received: from adsl-64-164-18-186.dsl.snfc21.pacbell.net ([64.164.18.186]:65093
	"HELO switchmanagement.com") by vger.kernel.org with SMTP
	id <S293659AbSCPCHK>; Fri, 15 Mar 2002 21:07:10 -0500
Message-ID: <3C92A8C8.7020000@switchmanagement.com>
Date: Fri, 15 Mar 2002 18:07:04 -0800
From: Brian Strand <bstrand@switchmanagement.com>
Organization: Switch Management
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Suse 2.4.16 LVM hangs with multiple snapshots of the same LV
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a single-processor ppro200 with 96M memory running Suse's 2.4.16 
kernel (k_deflt-2.4.16-22).  I am creating and mounting many (like 8-10) 
snapshots of the same logical volume over a week or so (a poor man's 
nightly backup, if you will).  The write activity on the source logical 
volume is limited to a brief period once per day, starting at 23:20; at 
all other times the source logical volume is mounted read-only.  The 
snapshot logs grow to about 3GB per snapshot volume before the oldest 
snapshot is removed.  So far, so good.

Unfortunately, the box falls over every few days doing this; it has 
lasted anywhere from 1 day to over 1 week.  Also, memtest completes one 
pass with 0 errors.  I got the following in the syslog before the latest 
hang:

Mar 11 23:24:12 dailies kernel: clm-2100: nesting info a different FS
Mar 11 23:24:44 dailies last message repeated 15 times
Mar 11 23:25:46 dailies last message repeated 94 times
Mar 11 23:26:48 dailies last message repeated 38 times
Mar 11 23:26:50 dailies last message repeated 2 times
Mar 11 23:37:35 dailies kernel: clm-2100: nesting info a different FS
Mar 11 23:38:27 dailies last message repeated 16 times
Mar 11 23:39:28 dailies last message repeated 33 times
Mar 11 23:40:01 dailies last message repeated 27 times
Mar 11 23:40:03 dailies kernel: clm-2100: nesting info a different FS
Mar 11 23:40:34 dailies last message repeated 22 times
Mar 11 23:41:35 dailies last message repeated 42 times
Mar 11 23:42:32 dailies last message repeated 72 times
Mar 11 23:44:22 dailies kernel: clm-2100: nesting info a different FS
Mar 11 23:45:23 dailies last message repeated 57 times
Mar 11 23:46:27 dailies last message repeated 31 times
Mar 11 23:47:28 dailies last message repeated 53 times
Mar 11 23:48:26 dailies last message repeated 81 times
Mar 11 23:49:27 dailies last message repeated 48 times

Is what I'm doing with the multiple snapshots supported and/or sane?  I 
found very little information in the various LVM howtos, Sistina, and 
google on creating multiple snapshots from a single LV.

Regards,
Brian


