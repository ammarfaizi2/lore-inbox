Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVCYVqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVCYVqM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVCYVqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:46:12 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11496 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261821AbVCYVpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:45:36 -0500
Subject: [PATCH] make Documentation/oops-tracing.txt relevant to 2.6 [was
	Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2]
From: Lee Revell <rlrevell@joe-job.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Miles Lane <miles.lane@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050325210743.E12715@flint.arm.linux.org.uk>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	 <a44ae5cd05032420122cd610bd@mail.gmail.com>
	 <20050324202215.663bd8a9.akpm@osdl.org>
	 <20050325073846.A18596@flint.arm.linux.org.uk>
	 <1111784022.23430.1.camel@mindpipe>
	 <20050325210743.E12715@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 16:45:32 -0500
Message-Id: <1111787132.23430.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 21:07 +0000, Russell King wrote:
> On Fri, Mar 25, 2005 at 03:53:42PM -0500, Lee Revell wrote:
> > On Fri, 2005-03-25 at 07:38 +0000, Russell King wrote:
> > > Users need to be re-educated _not_ to use ksymoops.
> > 
> > How about changing the fscking docs to not tell users to use it?
> 
> Would be useful.  The "fscking" problem is that no one actually owns the
> documents, so there's no central focus to keep them up to date.
> 

Are you serious?  So Documentation/sound/alsa/* isn't maintained by the
ALSA maintainers?

Wow, this would explain why all Linux documentation is at least 2 years
out of date.

> Maybe we need a docfsck? 8)
> 
> I certainly don't have authority to tell x86 people not to use ksymoops.
> Therefore, I think my suggested change (which up until recently I thought
> was an ARM only problem) should be done by someone else.
> 

At least from my experience, ksymoops is useless on x86 for 2.6 kernels.
Here is a patch to finally bring oops-tracing.txt into the 2.6 era.  :-P

Sugned-Off-By: Lee Revell <rlrevell@joe-job.com>

Lee

--- Documentation/oops-tracing.txt~	2005-03-17 20:34:06.000000000 -0500
+++ Documentation/oops-tracing.txt	2005-03-25 16:41:07.000000000 -0500
@@ -1,23 +1,22 @@
+NOTE: ksymoops is useless on 2.6.  Please use the Oops in its original format
+(from dmesg, etc).  Ignore any references in this or other docs to "decoding
+the Oops" or "running it through ksymoops".  If you post an Oops fron 2.6 that
+has been run through ksymoops, people will just tell you to repost it.
+
 Quick Summary
 -------------
 
-Install ksymoops from
-ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops
-Read the ksymoops man page.
-ksymoops < the_oops.txt
-
-and send the output the maintainer of the kernel area that seems to be
-involved with the problem, not to the ksymoops maintainer. Don't worry
-too much about getting the wrong person. If you are unsure send it to
-the person responsible for the code relevant to what you were doing.
-If it occurs repeatably try and describe how to recreate it. Thats
-worth even more than the oops
+Find the Oops and send it to the maintainer of the kernel area that seems to be
+involved with the problem.  Don't worry too much about getting the wrong person.
+If you are unsure send it to the person responsible for the code relevant to
+what you were doing.  If it occurs repeatably try and describe how to recreate
+it.  That's worth even more than the oops.
 
 If you are totally stumped as to whom to send the report, send it to 
 linux-kernel@vger.kernel.org. Thanks for your help in making Linux as
 stable as humanly possible.
 
-Where is the_oops.txt?
+Where is the Oops?
 ----------------------
 
 Normally the Oops text is read from the kernel buffers by klogd and
@@ -43,15 +42,14 @@
     them yourself.  Search kernel archives for kmsgdump, lkcd and
     oops+smram.
 
-No matter how you capture the log output, feed the resulting file to
-ksymoops along with /proc/ksyms and /proc/modules that applied at the
-time of the crash.  /var/log/ksymoops can be useful to capture the
-latter, man ksymoops for details.
-
 
 Full Information
 ----------------
 
+NOTE: the message from Linus below applies to 2.4 kernel.  I have preserved it
+for historical reasons, and because some of the information in it still
+applies.  Especially, please ignore any references to ksymoops. 
+
 From: Linus Torvalds <torvalds@osdl.org>
 
 How to track down an Oops.. [originally a mail to linux-kernel]


