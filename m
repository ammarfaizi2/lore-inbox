Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVGPVMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVGPVMu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 17:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbVGPVMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 17:12:50 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:44443 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261880AbVGPVMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 17:12:49 -0400
Date: Sat, 16 Jul 2005 23:07:59 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com, varap@us.ibm.com,
       richardj_moore@uk.ibm.com, relayfs-devel@lists.sourceforge.net
Subject: relayfs documentation sucks?
Message-ID: <20050716210759.GA1850@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Tom Zanussi <zanussi@us.ibm.com>, linux-kernel@vger.kernel.org,
	karim@opersys.com, varap@us.ibm.com, richardj_moore@uk.ibm.com,
	relayfs-devel@lists.sourceforge.net
References: <17107.6290.734560.231978@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17107.6290.734560.231978@tut.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'm working furiously on my OLS presentation (Wednesday, 3pm, be
there), but I'm running into a wall with relayfs, which I intend to use to
convey large amounts of disk statistics towards userspace.

Now, I've read Documentation/filesystems/relayfs.txt many times over, and I
don't get it.

It appears there is relayfs, and 'klog' on top of that. It also appears that
to access relayed data from the kernel in userspace there is librelay.c.

On reading librelay.c, I find code sending and receiving netlink
messages, but relayfs.txt doesn't even contain the word netlink!

I then launched the 'kleak-app' sample program, but told it to look at
/relay/diskstat* instead of its own file, but it gives me unspecified
netlink errors.

Things I need to know, and which I hope to find documented somewhere:

1) Do I need to do the netlink thing?
2) What kind of messages do I need to send/receive?
3) What is the exact format userspace sees in the relayfs file? Iow, can I
   access that file w/o using librelay.c?
4) What are the semantics for reading from that file?
5) When using klog, is there only one channel?
6) does librelay.c talk to regular relayfs or to klog?

Don't get me wrong, relayfs sure looks nice for what I'm trying to do but
from userspace it is sort of a black box right now..

Thanks!
	
-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
