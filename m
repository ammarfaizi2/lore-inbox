Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVACETt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVACETt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 23:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVACETt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 23:19:49 -0500
Received: from mail.tmr.com ([216.238.38.203]:11648 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S261299AbVACETs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 23:19:48 -0500
Message-ID: <41D8C55A.5010801@tmr.com>
Date: Sun, 02 Jan 2005 23:08:58 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel M/L <linux-kernel@vger.kernel.org>
Subject: 2.6.10-ac2 - more cdrecord wierdness
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to write a backup CD. The first write goes fine, I have rw 
permission on the device, I use /dev/hdc, all is fine. I can mount the 
CD, read it, etc.

However - it was written with the -multi option so I can add things to 
it, since most of my backups are 50MB at a time. When I try to get the 
size (using a perl script) which does:
  cdrecord dev=/dev/hdc -msinfo
I get permission denied. Even if I set cdrecord setuid (as a test, I 
don't run that way).

Back to ide-scsi, the perl program allows me to have the best features 
of growisofs and some other usefulk features for backing up relatively 
small datasets on a single CD.

Just a FYI - I assume there's a good reason why reading the unclosed 
filesystem size would compromise security.
