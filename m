Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbSKLXaw>; Tue, 12 Nov 2002 18:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbSKLXaw>; Tue, 12 Nov 2002 18:30:52 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:53482 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267025AbSKLXav>;
	Tue, 12 Nov 2002 18:30:51 -0500
Message-ID: <3DD18FB3.8060605@us.ibm.com>
Date: Tue, 12 Nov 2002 15:33:07 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Martin Bligh <mjbligh@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: [patch] Fix asm-i386/topology.h
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
	This patch fixes some slow, quickly written macros in 
asm-i386/topology.h.  The new versions use value caching in arrays to 
greatly speed up topology queries.

Please apply.

[mcd@arrakis patches]$ diffstat i386_topology_fixup-2.5.47.patch
  arch/i386/kernel/smpboot.c  |   43 
+++++++++++++++++++++++++++++++++++++++++++
  include/asm-i386/smpboot.h  |    8 ++++++++
  include/asm-i386/topology.h |   43 
+++++--------------------------------------
  3 files changed, 56 insertions(+), 38 deletions(-)

Cheers!

-Matt

