Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbUDQTsq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 15:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbUDQTsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 15:48:46 -0400
Received: from bay16-f57.bay16.hotmail.com ([65.54.186.107]:34565 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264025AbUDQTso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 15:48:44 -0400
X-Originating-IP: [69.40.24.195]
X-Originating-Email: [bobsmith401@hotmail.com]
From: "Bob Smith" <bobsmith401@hotmail.com>
To: linux-kernel@vger.kernel.org, suse-linux-e@suse.com,
       kde-linux@mail.kde.org
Subject: HELP: Konqueror 3.2 hangs SuSE 2.4.21-202-smp4G in 'ps uax'
Date: Sat, 17 Apr 2004 15:48:41 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY16-F57FTS0aWrz4e0001940c@hotmail.com>
X-OriginalArrivalTime: 17 Apr 2004 19:48:41.0804 (UTC) FILETIME=[FC40E0C0:01C424B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not quite sure where to target this, redirects welcome.

I'm cross-posting because SuSE 2.4.21-202-smp4G is quasi-hanging when 
accessing process information, particularly noticeable in Konquer sessions.  
I'm asking now instead of researching further because I'm not sure where to 
go from here, and because it's happening sooner and sooner after reboot.

The problem initially manifests as a Konqueror freeze.  New process creation 
continues normally (i.e you can start more Konquerors, BASHs, etc.  The 
application does not respond, but KDE can kill the PID after it fails to 
respond.  (I have seen cases where KDE can't influence the program, but when 
a File | Exit works.  This was after a failed KDE 'Logoff' that  trashed 
keyboard functionality(no LED response), but retained mouse input)

ls /proc/[0-9]* does not hang, and does not show dramatic increase of 
entries, even after creating and killing 20-40 more processes during 
diagnosis.

ps uax, top  and the "KDE System Guard Process Table" all consistently hang. 
  ps consistently shows PIDs into the 2000's, but then hangs.   'for i in 
/proc/[0-9]* ; do echo $i ; ls $i ; done' hangs on a apparently random 
process. Further, gdb hangs when you try to 'attach' to the $i-th process in 
a new bash.

dmesg and /var/log/messages both look innocuous, as does the console.  After 
a failed KDE Logoff and a failed 'telinit 6'  from tty4, a Ctrl-Alt-Del on 
tty1 resulted in:

	INIT: Switching to runlevel 6
	INIT: Sending processes the TERM signal
	INIT: Sending processes the KILL signal
followed by a hang requiring a cold boot.

The system is configured through YaST pointed to:

tricia.cc.gatech.edu/pub/suse/suse/i386/current
and
ftp.suse.com/pub/suse/i386/supplementary/KDE/update_for_9.0/yast-source

_________________________________________________________________
Is your PC infected? Get a FREE online computer virus scan from McAfee® 
Security. http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

