Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbULWVzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbULWVzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 16:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbULWVzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 16:55:37 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:39833 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261309AbULWVzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 16:55:33 -0500
Subject: [RFC PATCH 0/10] Replace 'numnodes' with 'node_online_map'
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1103838712.3945.12.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 23 Dec 2004 13:51:52 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The next 10 messages will contain 10 patches to remove the global
variable 'numnodes' and replace it's use with manipulations of
'node_online_map'.  This will remove the requirement that nodes be
numbered sequentially [0 ... (numnodes-1)] with no gaps in the
numbering.  The removal of this requirement will facilitate node HotPlug
as well as remove the need for some of the arch-specific node
renumbering schemes in the kernel.  Several architectures have to map
their native node numbers to 'Linux' node numbers, and I hope that some
of this may be removed now.

The following 10 patches replace numnodes in arch-independent code and
the 9 architectures that reference numnodes (alpha, arm, i386, ia64,
m32r, mips, parisc, ppc64, & x86_64).  A rollup patch has been lightly
tested (aka: booted) on x86 & ppc64.

Cheers!

-Matt

