Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbTFKSBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 14:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTFKSBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 14:01:15 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3740 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S263187AbTFKSBJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 14:01:09 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation tweak to SendingPatches.
Date: Wed, 11 Jun 2003 14:17:01 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306111417.24269.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Random first stab at it, flame away.

(Yes, I'd be happy to split out the bit about log rolling into a separate
patch.  I probably should anyway, on general principles... :)

Rob

--- linux-2.5.70/Documentation/SubmittingPatches	2003-05-26 21:00:20.000000000 -0400
+++ linux-new/Documentation/SubmittingPatches	2003-06-11 14:01:23.000000000 -0400
@@ -92,6 +92,16 @@
 complete, that is OK.  Simply note "this patch depends on patch X"
 in your patch description.
 
+In politics, there's a concept called "log rolling", where unrelated
+amendments are bundled together so that changes people want grease the
+way for changes they don't.  Do not do this.  It's insulting.
+
+In coding, this sort of thing can be very subtle, such as performance increases
+that help your new version perform as well as the original while doing more
+work, but which could also have been applied to the original making it even
+faster.  The linux-kernel guys are very good at taking the chocolate coating
+and leaving the pill behind.  This can be very frustrating to developers, but
+it's one of the big reasons open source produces such excellent results.
 
 4) Select e-mail destination.
 
@@ -175,9 +185,14 @@
 If the patch does not apply cleanly to the latest kernel version,
 Linus will not apply it.
 
+9) Include PATCH in the subject
 
+Due to high e-mail traffic to Linus, and to linux-kernel, it is common
+convention to prefix your subject line with [PATCH].  This lets Linus
+and other kernel developers more easily distinguish patches from other
+e-mail discussions.
 
-9) Don't get discouraged.  Re-submit.
+10) Don't get discouraged.  Re-submit.
 
 After you have submitted your change, be patient and wait.  If Linus
 likes your change and applies it, it will appear in the next version
@@ -201,16 +216,56 @@
 
 When in doubt, solicit comments on linux-kernel mailing list.
 
+11) Follow the chain (or "Why is Linus ignoring me?")
 
-
-10) Include PATCH in the subject
-
-Due to high e-mail traffic to Linus, and to linux-kernel, it is common
-convention to prefix your subject line with [PATCH].  This lets Linus
-and other kernel developers more easily distinguish patches from other
-e-mail discussions.
-
-
+These days, Linus is too overwhelmed to reliably accept patches directly
+from developers he doesn't know.  Furthermore, Linus is unlikely to respond
+to unsolicited email, since he gets so much of it he reads most with the
+delete key.  If your patch is being repeatedly ignored, resending it more than
+a few times can get frustrating.  There's a better way.
+
+The slow but steady way to get patches into the development kernel is a three
+step process:
+
+  A) Get the maintainer's approval.
+  B) Get the subsystem lieutenant's approval.
+  C) Get it to Linus.
+
+The maintainer is listed in the MAINTAINERS file.  This is the first person
+you should approach with your patch, as they're the only ones who owe you
+any kind of response if they've never heard of you before.  (Notice they
+do not owe you a _polite_ response.  Be nice.)
+
+Maintainers report to lieutenants, which are like subsystem maintainers.
+There are over a hundred maintainers, but only about a dozen lieutenants.
+They're not listed anywhere, but the maintainer you contact should know who
+they report to.  (If the maintainer doesn't respond after a week or so,
+you could try asking on linux kernel.)  The maintainer may take your patch
+and forward it on themselves, or sign off on it and send you on to the
+appropriate lieutanant with their blessing but not their spare time.
+
+Lieutanants report to Linus.  They're the only people who can ding him
+for not answering their email.  Linus responds fairly reliably to his
+lieutenants, lieutenants respond to maintainers, and maintainers should
+respond to you.  If you follow the chain, at each stage you will be talking
+to somebody who more or less owes you an answer, even if that answer is "no".
+
+The farther away from Linus people are, the more time they're likely to have
+to respond to your email.  The response may be "no, that's a bad idea", but
+it's better than being left hanging.
+
+11) Listen to feedback.
+
+If a maintainer, lieutenant, or Linus tells you something specific is wrong
+with your patch, this is a GOOD thing.  It means you've been given the
+opportunity to fix it.  It's not meant to be discouraging, if they wanted to
+discourage you they'd either ignore you or explicitly tell you to stop
+bothering them.
+
+If Linus himself replies to you by telling you your patch has something wrong
+with it, you have just been encouraged.  Same goes for lieutenants and
+maintainers.  When they tell you what you need to do to make the thing
+palatable to them, you've been given the opportunity to fix it and resubmit.
 
 -----------------------------------
 SECTION 2 - HINTS, TIPS, AND TRICKS

