Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131339AbQLNDFd>; Wed, 13 Dec 2000 22:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131532AbQLNDFY>; Wed, 13 Dec 2000 22:05:24 -0500
Received: from adsl-63-194-20-32.dsl.lsan03.pacbell.net ([63.194.20.32]:32261
	"EHLO symonds.net") by vger.kernel.org with ESMTP
	id <S131339AbQLNDFT>; Wed, 13 Dec 2000 22:05:19 -0500
Message-ID: <079301c06576$b303f060$0301a8c0@symonds.net>
From: "Mark Symonds" <mark@symonds.net>
To: <linux-kernel@vger.kernel.org>
Subject: VM problems still in 2.2.18
Date: Wed, 13 Dec 2000 18:36:44 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

I upgraded from 2.2.14 to 2.2.16 after the security
bug was discovered.  Ever since, I have two boxes here
that keep falling over.  Box A will randomly lock without 
warning and box B will die and start printing this message 
repeatedly on the screen until I physically hit reset:

VM: do_try_to_free_pages failed for cron...

...or something similar (could be apache etc.)

I tried upgrading to 2.2.17 for a week and the problem 
didn't go away, installed 2.2.18 last night and the problem 
is still there.  Don't know what to do since anything 
> 2.2.14 is very unstable on these machines, and anything
< 2.2.14 has the security bug.

Both machines have lots of these in the logs, just as others
have reported it happens in spurts:

Dec 13 08:00:12 symonds kernel: VM: do_try_to_free_pages failed for kupdate...
Dec 13 08:00:12 symonds kernel: VM: do_try_to_free_pages failed for eggdrop...
Dec 13 08:00:12 symonds kernel: VM: do_try_to_free_pages failed for mysqld...
Dec 13 08:00:12 symonds kernel: VM: do_try_to_free_pages failed for apache...
Dec 13 08:00:12 symonds kernel: VM: do_try_to_free_pages failed for eggdrop...
Dec 13 08:00:12 symonds kernel: VM: do_try_to_free_pages failed for klogd...
Dec 13 08:00:12 symonds kernel: VM: do_try_to_free_pages failed for eggdrop...
Dec 13 08:00:12 symonds kernel: VM: do_try_to_free_pages failed for init...
Dec 13 08:00:12 symonds kernel: VM: do_try_to_free_pages failed for traceroute...

...etc.

Sometimes this will happen 10 minutes after a reboot,
or 45 mins, but neither machine will stay up for more 
than 30 hours or so (usually *much* less).  

Something else I noticed is that the Load average 
is usually around 0.08, but when I let it idle for a 
few mins, just tapping the spacebar in a terminal will 
cause it to stop responding for 10 or so seconds with 
the load average skyrocketing to over 6.  After that the 
system sometimes recovers and starts responding normally, 
other times it will die.

Is there a patch out there that I can apply to 2.2.14
against the security bug?  The machines were very stable
on that kernel.

Anything I can do from userland to help, let me know.

--
Mark

grep me no patterns and I'll tell you no lines.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
