Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265171AbUAORab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 12:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265179AbUAORab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 12:30:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:57515 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265171AbUAORa3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 12:30:29 -0500
Date: Thu, 15 Jan 2004 09:26:55 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, matthew.e.tolentino@intel.com,
       Matt_Domsch@dell.com
Subject: Re: [PATCH] EFI zero-page usage (keeping docs updated)
Message-Id: <20040115092655.2d7c9c92.rddunlap@osdl.org>
In-Reply-To: <4005FC5D.8030407@stesmi.com>
References: <20040114164738.5be4a4a3.rddunlap@osdl.org>
	<4005FC5D.8030407@stesmi.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004 03:35:09 +0100 Stefan Smietanowski <stesmi@stesmi.com> wrote:

| Hi Randy.
| 
| > Add x86 EFI zero-page usage to i386 docs.
| > 
| > Please apply to 2.6.current...
| >   0xb0 - 0x1df		Free. Add more parameters here if you really need them.
|             ^^^^^
| 
| Change that to 0x1c3 instead since it's now used by EFI :)

Thanks, Stefan.
Here's the updated patch.



Add x86 EFI zero-page usage to i386 docs.

Please apply.

KERNELRELEASE:	2.6.1

diffstat:=
 Documentation/i386/zero-page.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -Naurp ./Documentation/i386/zero-page.txt~efidocs ./Documentation/i386/zero-page.txt
--- ./Documentation/i386/zero-page.txt~efidocs	2004-01-08 22:59:26.000000000 -0800
+++ ./Documentation/i386/zero-page.txt	2004-01-15 09:26:06.000000000 -0800
@@ -28,8 +28,13 @@ Offset	Type		Description
 
  0xa0	16 bytes	System description table truncated to 16 bytes.
 			( struct sys_desc_table_struct )
- 0xb0 - 0x1df		Free. Add more parameters here if you really need them.
+ 0xb0 - 0x1c3		Free. Add more parameters here if you really need them.
 
+0x1c4	unsigned long	EFI system table pointer
+0x1c8	unsigned long	EFI memory descriptor size
+0x1cc	unsigned long	EFI memory descriptor version
+0x1d0	unsigned long	EFI memory descriptor map pointer
+0x1d4	unsigned long	EFI memory descriptor map size
 0x1e0	unsigned long	ALT_MEM_K, alternative mem check, in Kb
 0x1e8	char		number of entries in E820MAP (below)
 0x1e9	unsigned char	number of entries in EDDBUF (below)
