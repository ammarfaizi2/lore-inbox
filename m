Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131360AbQLVSl6>; Fri, 22 Dec 2000 13:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbQLVSlr>; Fri, 22 Dec 2000 13:41:47 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:7296 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S131360AbQLVSle>;
	Fri, 22 Dec 2000 13:41:34 -0500
Date: Fri, 22 Dec 2000 10:11:06 -0800 (PST)
From: J J Sloan <jjs@mirai.cx>
To: linux-kernel@vger.kernel.org
Subject: drm woes continue in test13-pre4
Message-ID: <Pine.LNX.4.10.10012221002580.812-100000@mirai.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Up to and including -test12, tdfx.o has built and run nicely.

Starting with -test13-pre1, and continuing to -test13-pre4,
tdfx.o (and other modules e,g the olympic.o token ring driver)
have not been successfully created. In general, modules work fine,
it's just a few that have been broken byu the makefile changes.

# uname -r
2.4.0-test13-pre4 

# lsmod
Module                  Size  Used by
iptable_filter          1872   0  (autoclean) (unused)
ip_nat_ftp              3408   0  (unused)
iptable_nat            12672   1  [ip_nat_ftp]
ip_conntrack_ftp        2048   0  (unused)
ip_conntrack           13056   2  [ip_nat_ftp iptable_nat
ip_conntrack_ftp]
ip_tables              10624   4  [iptable_filter iptable_nat]
ide-scsi                8096   0 
8139too                15632   2  (autoclean)
emu10k1                45232   0 

However, "modprobe tdfx" yields 34 lines of "unresolved symbol" 
messages and a failure to load the module.

Other info: 
modutils version: 2.3.21
gcc version: egcs-2.91.66

More info on request

Hope this helps direct attention to the problem -

jjs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
