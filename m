Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264846AbTF2WDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 18:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbTF2WDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 18:03:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:45035 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264846AbTF2WDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 18:03:23 -0400
Date: Mon, 30 Jun 2003 00:17:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Matt_Domsch@Dell.com, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] postfix a constant in efi.h with ULL
Message-ID: <20030629221735.GE282@fs.tum.de>
References: <16E52145F803EF44BE0CAB504CEF34E70115A5E9@ausx2kmpc106.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16E52145F803EF44BE0CAB504CEF34E70115A5E9@ausx2kmpc106.aus.amer.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 04:27:07PM -0500, Matt_Domsch@Dell.com wrote:
> > The patch below postfixes a constant in efi.h with ULL, on 32 bit archs
> > this constant is too big for an int.
> > -#define GPT_HEADER_SIGNATURE 0x5452415020494645L
> > +#define GPT_HEADER_SIGNATURE 0x5452415020494645ULL
> 
> Sounds good.  Please submit for 2.4.x also.

Marcelo, this trivial patch is below. Please apply.

> Thanks,
> Matt

cu
Adrian

--- linux-2.5.73-not-full/fs/partitions/efi.h.old	2003-06-23 21:01:29.000000000 +0200
+++ linux-2.5.73-not-full/fs/partitions/efi.h	2003-06-23 21:01:42.000000000 +0200
@@ -40,7 +40,7 @@
 #define EFI_PMBR_OSTYPE_EFI_GPT 0xEE
 
 #define GPT_BLOCK_SIZE 512
-#define GPT_HEADER_SIGNATURE 0x5452415020494645L
+#define GPT_HEADER_SIGNATURE 0x5452415020494645ULL
 #define GPT_HEADER_REVISION_V1 0x00010000
 #define GPT_PRIMARY_PARTITION_TABLE_LBA 1
 
