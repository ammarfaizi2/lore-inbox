Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbTHXMML (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263417AbTHXMML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:12:11 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:13227 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263536AbTHXMLy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:11:54 -0400
Date: Sun, 24 Aug 2003 14:11:52 +0200 (MEST)
Message-Id: <200308241211.h7OCBq7T014859@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@muc.de
Subject: [BUG] 2.4.22-rc3 broke x86-64 ia32 emulation?
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.22-rc3 appears to have broken x86-64's ia32-emulation.
Now, whenever I run a 32-bit binary I get general protection
and a core dump:

strace32[371] general protection rip:4000e8fb rsp:ffffd8bc error:400
strace32[374] general protection rip:4000e8fb rsp:ffffd8ec error:400
lilo[376] general protection rip:4000e8fb rsp:ffffd8ec error:400
self[383] general protection rip:4000e8fb rsp:ffffd8ec error:400

2.4.22-rc2 and 2.6.0-test4 work fine.

My user-space is GinGin64 (RH 8.0.95 for x86-64) with 32-bit glibc
and lilo from RH8.0. 'strace32' above is a copy of RH9's strace;
I tried it since I could never get the 64-bit strace to work with
32-bit binaries.

/Mikael
