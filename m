Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129155AbRCEK4W>; Mon, 5 Mar 2001 05:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129156AbRCEK4L>; Mon, 5 Mar 2001 05:56:11 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:8876 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S129155AbRCEK4H>; Mon, 5 Mar 2001 05:56:07 -0500
Date: Mon, 5 Mar 2001 11:00:00 +0000 (GMT)
From: Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>
To: linux-kernel@vger.kernel.org
Subject: locked pts/x
Message-ID: <Pine.LNX.4.21.0103051050170.6480-100000@erdos.shef.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

This isn't really a problem - everything works, but, rather, a VERY
strange (as it appears to me) behaviour. I looked through lkml's archives,
asked several news-groups - no success. So, here goes:

I am observing this behaviour on 2 VERY different machines, but I'll
describe one of them to make it easier. Maybe it's a known feature, so,
you'll tell me straight away. Shortly - when opening new remote sessions
some pts's don't get allocated, although they are not currently in use by
any login (`who`), and corresponding /dev/pts/x don't exist. Already know
what it is? If not - I'll give a bit more detail. This machine is running
2.2.18 (another one 2.4.2). It doesn't have X installed on it (only couple
X-clients, including rxvt - an xterm clone. So, - it went like this:
1) open rxvt, pts/2 appears, `who` has extra line (I didn't check, but I
assume)
2) rxvt crashes, pts/2 disappears, line in who stays, pts/2 locked
3) I re-initialize /var/run/utmp, line in who goes, pts/2 still locked
(present state)

On another occasion pts/4 got locked in exactly the same way, but before
I re-initialized utmp, one of terminals got associated with pts/4 (then
who produced 2 lines with pts/4!), and, when I closed that other session
with pts/4 both lines from who disappeared and pts/4 got unlocked! VERY
weird, to say the least:-)

On another machine pts's get locked also when ssh sessions get cut.

Any ideas?
Thanks
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk



