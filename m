Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269542AbTHOQZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269514AbTHOQNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:13:18 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269542AbTHOQJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:37 -0400
To: linux-kernel@vger.kernel.org
Subject: Scheduler issue?
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 15 Aug 2003 16:21:44 +0200
Message-ID: <yw1xadabf1c7.fsf@users.sourceforge.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


First the machine details.  It's a Pentium4 running at 2 GHz.  Linux
version 2.6.0-test3 + O15int + softrr.

I just experienced something that might be a scheduler problem.  I was
working in XEmacs, when suddenly the machine became very
unresponsive.  The mouse pointer in X moved sporadically.  I could
switch to a text console and log in, though typing lagged tens of
seconds.  Switching between text consoles was fast, though.  I killed
xemacs, and the system was back to normal.  Further investigation
showed that xemacs was stuck in a nasty regexp match.  If I was quick
enough, I could interrupt it with C-g.

With X and the window manager reniced to -10, they seem to be able to
get their job done.  This leads me to believe that maybe xemacs is
considered interactive, and given too high priority when it suddenly
starts burning the cpu.

I'll try it later with other kernel versions, but right now I don't
want to reboot.

What can I do to collect more information about the problem?

-- 
Måns Rullgård
mru@users.sf.net
