Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264959AbSJ3Xkn>; Wed, 30 Oct 2002 18:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264962AbSJ3Xkn>; Wed, 30 Oct 2002 18:40:43 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:51634 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264959AbSJ3Xkk>;
	Wed, 30 Oct 2002 18:40:40 -0500
Message-ID: <3DC06E75.6010003@us.ibm.com>
Date: Wed, 30 Oct 2002 15:42:45 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Patrick Mansfield <patmans@us.ibm.com>
Subject: [patch] pcibus_to_node() addition to topology infrastructure
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
	Here's a patch that adds PCI busses to the list of basic topology 
elements (incl. CPUs, MemBlks, & Nodes).

pcibus_to_node-2.5.44.patch

This patch adds a new topology macro: pcibus_to_node().  This will be 
useful to allow I/O bound processes to bind themselves to CPUs/Nodes 
close to the PCI busses they are communicating over.

1) Adds pcibus_to_node() macro to asm-generic/topology.h
2) Makes small modifications to NUMA-Q PCI code, mostly modifying macros.
3) Uses the macros from #2 to implement pcibus_to_node() in 
asm-i386/topology.h

[mcd@arrakis patches]$ diffstat api_patches/pcibus_to_node-2.5.44.patch
  arch/i386/pci/numa.c           |   33 +++++++++++++++------------------
  include/asm-generic/topology.h |    3 +++
  include/asm-i386/topology.h    |    3 +++
  3 files changed, 21 insertions(+), 18 deletions(-)

Cheers!

-Matt

