Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752430AbWJ0Tb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbWJ0Tb6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 15:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbWJ0Tb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 15:31:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:37477 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752430AbWJ0Tb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 15:31:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AnolKWc4j9byma1UQEtcbmge2LZYBNgvFux9ihgtu5FOvtdacH8CNNj4su/yFW7jeWhMr0kqqTS+uxQrOJZ9BH0XI0PpXpId/o4nt5+LhOyz6ehla4uiMCGhf4Hk3obIfm4mpxXS8OR5oG3HQ+fA70ogBDBLEVzkCpjj7So1AjQ=
Message-ID: <1defaf580610271231p37aceacbl6d96f91cf390fc4a@mail.gmail.com>
Date: Fri, 27 Oct 2006 21:31:55 +0200
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: vmlinux.lds: consolidate initcall sections
Cc: "Pavel Machek" <pavel@ucw.cz>, "Greg KH" <greg@kroah.com>,
       "Stephen Hemminger" <shemminger@osdl.org>,
       "Matthew Wilcox" <matthew@wil.cx>, "Adrian Bunk" <bunk@stusta.de>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061027114144.f8a5addc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	 <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de>
	 <20061027012058.GH5591@parisc-linux.org>
	 <20061026182838.ac2c7e20.akpm@osdl.org>
	 <20061026191131.003f141d@localhost.localdomain>
	 <20061027170748.GA9020@kroah.com> <20061027172219.GC30416@elf.ucw.cz>
	 <20061027113908.4a82c28a.akpm@osdl.org>
	 <20061027114144.f8a5addc.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/06, Andrew Morton <akpm@osdl.org> wrote:
> From: Andrew Morton <akpm@osdl.org>
>
> Add a vmlinux.lds.h helper macro for defining the eight-level initcall table,
> teach all the architectures to use it.

Please include AVR32 as well while you're at it ;)

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/kernel/vmlinux.lds.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/avr32/kernel/vmlinux.lds.c b/arch/avr32/kernel/vmlinux.lds.c
index cdd627c..5c4424e 100644
--- a/arch/avr32/kernel/vmlinux.lds.c
+++ b/arch/avr32/kernel/vmlinux.lds.c
@@ -38,13 +38,7 @@ SECTIONS
 		__setup_end = .;
 		. = ALIGN(4);
 		__initcall_start = .;
-			*(.initcall1.init)
-			*(.initcall2.init)
-			*(.initcall3.init)
-			*(.initcall4.init)
-			*(.initcall5.init)
-			*(.initcall6.init)
-			*(.initcall7.init)
+			INITCALLS
 		__initcall_end = .;
 		__con_initcall_start = .;
 			*(.con_initcall.init)
-- 
1.4.1.1
