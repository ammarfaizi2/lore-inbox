Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbUAOPPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 10:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUAOPPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 10:15:21 -0500
Received: from imf16aec.mail.bellsouth.net ([205.152.59.64]:10424 "EHLO
	imf16aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S263587AbUAOPPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 10:15:15 -0500
Message-ID: <4006A904.3000307@bellsouth.net>
Date: Thu, 15 Jan 2004 09:51:48 -0500
From: Craig Taylor <ctalkobt@bellsouth.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Haakon Riiser <haakon.riiser@fys.uio.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: NTFS disk usage on Linux 2.6
References: <20040115010210.GA570@s.chello.no>
In-Reply-To: <20040115010210.GA570@s.chello.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do a "properties" within Windows on the folder - windows will report the 
_actual_ size of the file in it's listings, not the amount of space it 
takes up. I presume that that's what is going on.

Haakon Riiser wrote:

>Has anyone else noticed that the reported disk space usage on
>NTFS is completely unreliable on Linux 2.6?  Just issued the
>command "du -sh" on my main Windows XP partition, and on 2.6.1,
>the reported disk usage is bigger than the partition size.
>
>Here's the output from "du -sh *" in Windows' root directory
>under Linux 2.6.1:
>
>  0       AUTOEXEC.BAT
>  0       CONFIG.SYS
>  43M     Documents and Settings
>  0       IO.SYS
>  0       MSDOS.SYS
>  48K     NTDETECT.COM
>  366M    Program Files
>  0       RECYCLER
>  20K     System Volume Information
>  12G     WINDOWS
>  0       boot.ini
>  232K    ntldr
>  768M    pagefile.sys
>
>Same command on 2.4.24:
>
>  0       AUTOEXEC.BAT
>  0       CONFIG.SYS
>  41M     Documents and Settings
>  0       IO.SYS
>  0       MSDOS.SYS
>  48K     NTDETECT.COM
>  366M    Program Files
>  2.0K    RECYCLER
>  21K     System Volume Information
>  1.4G    WINDOWS
>  1.0K    boot.ini
>  230K    ntldr
>  770M    pagefile.sys
>
>(The contents of the filesystem was, of course, identical in both
>cases -- I did not run Windows in between these tests.)
>
>Compare the disk space used by the WINDOWS directory in the
>two listings.  On 2.4.24, it correctly reports 1.4G, while
>2.6.1 reports 12G, which is 2G more than the total space on
>the filesystem.
>
>I also compared this to the listings produced by "ls -lR"
>(summing the numbers on the "total ..." lines).  The result
>was the same as with du -sh.
>
>  
>

