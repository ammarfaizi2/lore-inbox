Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265056AbUEYTZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265056AbUEYTZA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265062AbUEYTZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:25:00 -0400
Received: from wolery.deas.harvard.edu ([140.247.50.121]:54236 "EHLO
	wolery.deas.harvard.edu") by vger.kernel.org with ESMTP
	id S265056AbUEYTYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:24:46 -0400
Date: Tue, 25 May 2004 15:24:42 -0400 (EDT)
From: Lars Kellogg-Stedman <lars@deas.harvard.edu>
To: linux-kernel@vger.kernel.org
Subject: Help diagnosing NFS lockups
Message-ID: <Pine.LNX.4.44.0405251221060.24855-100000@wolery.deas.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm hoping someone out there more kernel-knowledgeable than I can lend a 
hand in tracking down some NFS-related problems we're having with our 
Linux mailserver.

We're running RH9, with kernel 2.4.20-31.9.  The mail spool is mounted
from a Network Appliance filer (rw, fg, tcp, vers=3, timeo=600,
rsize=8192, wsize=8192, hard, intr).  There's also a lot of NFS
automounter activity on the box for user home directories
(rw,nosuid,intr).

Periodically, the load on this system spikes way up -- but not because any
processes are using CPU time.  Possibly there are "many" processes waiting
for IO, although "many" only appears to be around 53.  The culprit seems to
be that access to the NFS filesystem is "slow", but we haven't been able to
quantify this (so the problem may in fact be something else entirely).
Rebooting the system makes the problem go away temporarily.

Yes, we know the mail spool probably shouldn't sit on an NFS filesystem.
We're working on changing that, but this is what we inherited, and we only
started encountering these problems after migrating from an underpowered
Solaris box to an IBM Bladecenter running Linux (we're using the bcm5700
drivers, rather than than the tg3 drivers from the stock kernel, due in
part to reports of NFS lockups with the tg3 drivers on the blades).

Any suggestions people can send our way would be greatly appreciated.  If
you're in the Boston area and would like to discuss resolving this on
contract, we may be able to work something out.

I'd appreciate it if you would Cc: me on any replies.

-- Lars

-- 
Lars Kellogg-Stedman <lars@deas.harvard.edu>
IT Operations Manager
Division of Engineering and Applied Sciences
Harvard University


