Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268357AbUJOTRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268357AbUJOTRh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 15:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUJOTPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 15:15:48 -0400
Received: from mail.linicks.net ([217.204.244.146]:42508 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S268357AbUJOTJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 15:09:57 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Black Friday
Date: Fri, 15 Oct 2004 20:09:49 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410152009.49873.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is a story that happened to me today, and a sightly warning for any 
sysadmins that read here.

At 9:50 am on the 1st Oct (2 weeks ago), main file server at work crashed big 
time (a Snapserver 4100).  It trashed the RAID (240GB - 170GB usable [50GB 
free]), but the OS (BSD based, I believe) is pretty good and rebuilt it - 
took 8 hours - no data lost out of 120+ GB

I also have a second Snapserver that runs Quantums own synchronisation 
software, so that at any point it time, server 'b' is an exact copy of server 
'a' - this I set to sync at 1:00 am each day.  The idea being you can 
recover/swap from server to server real time.

The first crash proved problems I never thought off in disaster recover 
options.  The Snapserver synchronisation software doesn't 'sync' directory 
share nor file permissions - just the actual binary data.  So the 'copy' 
server 'b' is not as is server 'a'.

OK, so since that 'black Friday' two weeks ago, I hacked a way to get the file 
permissions from box ''a' to box 'b' replicated manually so at least a quick 
swap over from box 'a' to box 'b' would be possible and the change over for 
the users would be invisible and all file/share permissions are correct.

Today at 9:50 Snapserver box 'a' crashed again.  I suspected that it was dying 
now, and the better move would be to push everybody to the back up box 'b' 
and replace the dodgy box 'a' until I could replace it.

Except box 'b' was AWOL as well (I didn't scream exactly...).  That crashed 
too at 9:50 (yes, in sync with box 'a').  The 'sync' software is bloody 
good ;)

After a lengthy discussion with Snap engineers, it turns out the OS does a 
KERNEL PANIC after a certain number of file opens/shares get accessed on the 
version OS I was running.  It only does this once the server reaches the 
point of whatever threshhold causes it - i.e. a growing, expanding fileserver 
- they didn't really tell me, nor elaborate.

But because two weeks ago, only one server crashed, I put it down to the 
gremlins... but as 'a' had not sync'ed with 'b' yet, that is why only one 
crashed then, and as both are sync'ed since, today both of them.

Two weeks later, both have the same threshhold to cause the kernel crash.

Snap guys gave me new OS firmware to flash - I have done one server, the main 
server  tomorrow.

The gist of this mail?  Never, ever think you are safe.

Nick
P.S still have DLT backup anyway - but users want to USE NOW not wait :(

-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
