Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUAOBCS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUAOBCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:02:18 -0500
Received: from amsfep18-int.chello.nl ([213.46.243.14]:15639 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S264889AbUAOBCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:02:12 -0500
Date: Thu, 15 Jan 2004 02:02:10 +0100
From: Haakon Riiser <haakon.riiser@fys.uio.no>
To: linux-kernel@vger.kernel.org
Subject: NTFS disk usage on Linux 2.6
Message-ID: <20040115010210.GA570@s.chello.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone else noticed that the reported disk space usage on
NTFS is completely unreliable on Linux 2.6?  Just issued the
command "du -sh" on my main Windows XP partition, and on 2.6.1,
the reported disk usage is bigger than the partition size.

Here's the output from "du -sh *" in Windows' root directory
under Linux 2.6.1:

  0       AUTOEXEC.BAT
  0       CONFIG.SYS
  43M     Documents and Settings
  0       IO.SYS
  0       MSDOS.SYS
  48K     NTDETECT.COM
  366M    Program Files
  0       RECYCLER
  20K     System Volume Information
  12G     WINDOWS
  0       boot.ini
  232K    ntldr
  768M    pagefile.sys

Same command on 2.4.24:

  0       AUTOEXEC.BAT
  0       CONFIG.SYS
  41M     Documents and Settings
  0       IO.SYS
  0       MSDOS.SYS
  48K     NTDETECT.COM
  366M    Program Files
  2.0K    RECYCLER
  21K     System Volume Information
  1.4G    WINDOWS
  1.0K    boot.ini
  230K    ntldr
  770M    pagefile.sys

(The contents of the filesystem was, of course, identical in both
cases -- I did not run Windows in between these tests.)

Compare the disk space used by the WINDOWS directory in the
two listings.  On 2.4.24, it correctly reports 1.4G, while
2.6.1 reports 12G, which is 2G more than the total space on
the filesystem.

I also compared this to the listings produced by "ls -lR"
(summing the numbers on the "total ..." lines).  The result
was the same as with du -sh.

-- 
 Haakon
