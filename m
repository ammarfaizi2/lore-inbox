Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266337AbUAOAxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 19:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266400AbUAOAxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 19:53:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:57055 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266337AbUAOAvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 19:51:01 -0500
Date: Wed, 14 Jan 2004 16:47:38 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, matthew.e.tolentino@intel.com, Matt_Domsch@dell.com
Subject: [PATCH] EFI zero-page usage (keeping docs updated)
Message-Id: <20040114164738.5be4a4a3.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add x86 EFI zero-page usage to i386 docs.

Please apply to 2.6.current...

--
~Randy



diffstat:=
 Documentation/i386/zero-page.txt |    5 +++++
 1 files changed, 5 insertions(+)

diff -Naurp ./Documentation/i386/zero-page.txt~efidocs ./Documentation/i386/zero-page.txt
--- ./Documentation/i386/zero-page.txt~efidocs	2004-01-08 22:59:26.000000000 -0800
+++ ./Documentation/i386/zero-page.txt	2004-01-14 16:36:42.000000000 -0800
@@ -30,6 +30,11 @@ Offset	Type		Description
 			( struct sys_desc_table_struct )
  0xb0 - 0x1df		Free. Add more parameters here if you really need them.
 
+0x1c4	unsigned long	EFI system table pointer
+0x1c8	unsigned long	EFI memory descriptor size
+0x1cc	unsigned long	EFI memory descriptor version
+0x1d0	unsigned long	EFI memory descriptor map pointer
+0x1d4	unsigned long	EFI memory descriptor map size
 0x1e0	unsigned long	ALT_MEM_K, alternative mem check, in Kb
 0x1e8	char		number of entries in E820MAP (below)
 0x1e9	unsigned char	number of entries in EDDBUF (below)
