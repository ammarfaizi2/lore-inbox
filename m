Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264258AbTCYXDS>; Tue, 25 Mar 2003 18:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264298AbTCYXDS>; Tue, 25 Mar 2003 18:03:18 -0500
Received: from ibm-giga.math.tau.ac.il ([132.67.192.254]:39840 "EHLO tau.ac.il")
	by vger.kernel.org with ESMTP id <S264258AbTCYXDR>;
	Tue, 25 Mar 2003 18:03:17 -0500
Date: Wed, 26 Mar 2003 01:14:18 +0200
From: Yedidyah Bar-David <didi@tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20: kernel BUG at highmem.c:169!
Message-ID: <20030325231418.GA8112@ibm-giga.math.tau.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today, a machine with vanilla 2.4.20 hung with this in syslog:

kernel BUG at highmem.c:169!
invalid operand: 0000

The complete log can be found at
<http://www.cs.tau.ac.il/~didi/kern-bug-1-orig>, with a
hopefully well-decoded ksymoopsed output at
<http://www.cs.tau.ac.il/~didi/kern-bug-1-ksymed>.

When this happened, the machine still replied to ping, but not
to other things I tried (but I did not try much). The console
did not respond to anything, including Alt-SysRq-B (which is
verified to normally work).
I ran memtest86 for about an hour, no problems, and rebooted.

It's a Dual PIII-1000 with 4GB RAM, CONFIG_HIGHMEM4G=y (full
config here <http://www.cs.tau.ac.il/~didi/config-2.4.20-net1>),
with root (and everything else) on NFS. This might (or might not)
be related to a problem solved in 2.4.21-pre5, noticed as
"xdr nfs highmem deadlock fix" in the changelog.
google found no other BUG in this line (but did find in others).

Is this a known bug? A solved (in which version) bug?
Should I do anything else to make it not happen?
Tell me if you need more info.

I am not on lkml, so please CC me.

Thanks a lot!

	Didi

