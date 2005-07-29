Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVG2TSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVG2TSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbVG2TQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:16:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:31918 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262699AbVG2TPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:15:02 -0400
Date: Fri, 29 Jul 2005 12:14:34 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 05/29] Add the rules about the -stable kernel releases to the Documentation directory
Message-ID: <20050729191434.GG5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This was the last agreed upon set of rules, it's probably time we actually add
them to the kernel tree to make them "official".

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/stable_kernel_rules.txt |   58 ++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+)

--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ gregkh-2.6/Documentation/stable_kernel_rules.txt	2005-07-29 11:34:01.000000000 -0700
@@ -0,0 +1,58 @@
+Everything you ever wanted to know about Linux 2.6 -stable releases.
+
+Rules on what kind of patches are accepted, and what ones are not, into
+the "-stable" tree:
+
+ - It must be obviously correct and tested.
+ - It can not bigger than 100 lines, with context.
+ - It must fix only one thing.
+ - It must fix a real bug that bothers people (not a, "This could be a
+   problem..." type thing.)
+ - It must fix a problem that causes a build error (but not for things
+   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
+   security issue, or some "oh, that's not good" issue.  In short,
+   something critical.
+ - No "theoretical race condition" issues, unless an explanation of how
+   the race can be exploited.
+ - It can not contain any "trivial" fixes in it (spelling changes,
+   whitespace cleanups, etc.)
+ - It must be accepted by the relevant subsystem maintainer.
+ - It must follow Documentation/SubmittingPatches rules.
+
+
+Procedure for submitting patches to the -stable tree:
+
+ - Send the patch, after verifying that it follows the above rules, to
+   stable@kernel.org.
+ - The sender will receive an ack when the patch has been accepted into
+   the queue, or a nak if the patch is rejected.  This response might
+   take a few days, according to the developer's schedules.
+ - If accepted, the patch will be added to the -stable queue, for review
+   by other developers.
+ - Security patches should not be sent to this alias, but instead to the
+   documented security@kernel.org.
+
+
+Review cycle:
+
+ - When the -stable maintainers decide for a review cycle, the patches
+   will be sent to the review committee, and the maintainer of the
+   affected area of the patch (unless the submitter is the maintainer of
+   the area) and CC: to the linux-kernel mailing list.
+ - The review committee has 48 hours in which to ack or nak the patch.
+ - If the patch is rejected by a member of the committee, or linux-kernel
+   members object to the patch, bringing up issues that the maintainers
+   and members did not realize, the patch will be dropped from the
+   queue.
+ - At the end of the review cycle, the acked patches will be added to
+   the latest -stable release, and a new -stable release will happen.
+ - Security patches will be accepted into the -stable tree directly from
+   the security kernel team, and not go through the normal review cycle.
+   Contact the kernel security team for more details on this procedure.
+
+
+Review committe:
+
+ - This will be made up of a number of kernel developers who have
+   volunteered for this task, and a few that haven't.
+

--
