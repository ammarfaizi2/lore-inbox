Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVJ2R0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVJ2R0t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 13:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVJ2R0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 13:26:49 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:45830 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751154AbVJ2R0s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 13:26:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lZ09jpzofN0b+ewfGBJkADdZYoHpAoOE7Cj1sTaKtLOUxE28HVichCM3E7rvlBI/sw+RUps26TyJUc+FkmuHU+TpjPjlhQhm39MVFiml1ef086Go66hcTXkRjwCPOR36goeFAkJ/AgUbWfWKIho5FRZ4ynZRyr80YDyKTzgakKk=
Message-ID: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
Date: Sat, 29 Oct 2005 19:26:47 +0200
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: New (now current development process)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I would like to write a short article about the new development
process discussed during last Linux Kernel Developers' Summit for my
local LUG.

Since I'm not able to find an accurate report of what has been
discussed during that meeting I try to summariza what is my
understanding of the current process:

The are two kind of releases, 2.6.x kerneles and 2.6.x.y

2.6.x.y are maintained by the "stable" team (stable at kernel dot
org), are released amost every week.

Here is the latest ( I hope ) announce I found in the archive
including an explanation of how stable development works:

Rules on what kind of patches are accepted, and what ones are not, into
the "-stable" tree:
 - It must be obviously correct and tested.
 - It can not bigger than 100 lines, with context.
 - It must fix only one thing.
 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing.)
 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short,
   something critical.
 - No "theoretical race condition" issues, unless an explanation of how
   the race can be exploited.
 - It can not contain any "trivial" fixes in it (spelling changes,
   whitespace cleanups, etc.)
 - It must be accepted by the relevant subsystem maintainer.
 - It must follow Documentation/SubmittingPatches rules.

Procedure for submitting patches to the -stable tree:
 - Send the patch, after verifying that it follows the above rules, to
   stable@kernel.org.
 - The sender will receive an ack when the patch has been accepted into
   the queue, or a nak if the patch is rejected.  This response might
   take a few days, according to the developer's schedules.
 - If accepted, the patch will be added to the -stable queue, for review
   by other developers.
 - Security patches should not be sent to this alias, but instead to the
   documented security@kernel.org.

Review cycle:
 - When the -stable maintainers decide for a review cycle, the patches
   will be sent to the review committee, and the maintainer of the
   affected area of the patch (unless the submitter is the maintainer of
   the area) and CC: to the linux-kernel mailing list.
 - The review committee has 48 hours in which to ack or nak the patch.
 - If the patch is rejected by a member of the committee, or linux-kernel
   members object to the patch by bringing up issues that the maintainer
   and members did not realize, the patch will be dropped from the
   queue.
 - At the end of the review cycle, the acked patches will be added to
   the latest -stable release, and a new -stable release will happen.
 - Security patches will be accepted into the -stable tree directly from
   the security kernel team, and not go through the normal review cycle.
   Contact the kernel security team for more details on this procedure.

Review committe:
 - This will be made up of a number of kernel developers who have
   volunteered for this task, and a few that haven't.

2.6.x kernel are maintained by Linus Torvalds and Andrew Morton (both
are from OSDL) and the development is as follow:
- As soon a new kernel is released a two weeks windows is open, during
this period of time maintainers can submit big diffs to Linus (usually
the patched sitted in -mm kernels for a few weeks). Preferred way to
submit big changes is using GIT ( more information about GIT at
http://git.or.cz/ and
http://www.kernel.org/pub/software/scm/git/docs/tutorial.html).
- After two weeks a -rc1 kernel is released and now is possible to
push only patches that do not include new functionalities)
- Aftwer two weeks -rc2 is released
- Process continues until the kernel is considered "ready", the
process should last three months ( 4 kernels per yeard should be
released).


I'm sure I'm missing lot of details so I would really appreciate if
you could support me in writing this article that hopefully will be
usefull outside my LUG as well :-)

Thanks in advance.

--
Paolo
