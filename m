Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSBJGF2>; Sun, 10 Feb 2002 01:05:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289299AbSBJGFT>; Sun, 10 Feb 2002 01:05:19 -0500
Received: from 1Cust130.tnt15.sfo3.da.uu.net ([67.218.75.130]:5393 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S289298AbSBJGFI>;
	Sun, 10 Feb 2002 01:05:08 -0500
Date: Sun, 10 Feb 2002 01:13:15 -0800 (PST)
Message-Id: <200202100913.BAA29987@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: linux-kernel@vger.kernel.org
Subject: a new arch feature "for Linus"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not really only for Linus, but inspired by a feature he requested 
of Bitkeeper on this list a few weeks ago.

The command is:

	  % arch touched-files-prereqs REVISION

That command looks at the patch set for REVISION and at all preceding
patch sets in the same version (aka "Line of Development"[1]).  It
reports the list of patches that touch overlapping sets of files and
directories -- in other words, it tells you what patches can be
applied independently of others (from "linear" to "bushy" patch sets).
The command has an option to exclude from consideration file names
matching a certain pattern (e.g. "=README" or "ChangeLog").  It has an
option to exclude from the output list patches which have already been
applied to a given project tree.  It has an option to report the
specific files which are overlapped.

Linus actually asked for something slightly more precise: beyond
looking at whether two patch sets modify the same files, he wants to
know if they specifically modify overlapping sections of those files.  
I haven't implemented that yet but it's certainly doable.
(`touched-files-prereqs' is 297 lines long; delving into the patch
details will likely more than double that.)

We now return you to your previously scheduled Bitkeeper product
placement advertisement.

Pepsi adds life!,
-t

[1] "Lines of Development" is a trademark of BitMover, Inc.

