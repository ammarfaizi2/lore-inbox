Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUAMDsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 22:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUAMDsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 22:48:30 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:6547 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263475AbUAMDs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 22:48:28 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Lorenzo Hernandez Garcia-Hierro <lorenzohgh@nsrg-security.com>
Date: Tue, 13 Jan 2004 14:48:21 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16387.27269.8538.507466@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Noise with  2.6.0 in a Dell Laptop ( Latitude c600 )
In-Reply-To: message from Lorenzo Hernandez Garcia-Hierro on  January 7
References: <1073488405.850.35.camel@zeus>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  January 7, lorenzohgh@nsrg-security.com wrote:
> 
> Hi,
> 
> When the 2.6.0 inits in my laptop it becomes reaaallyyy noisy.
> Why ?

What sort of noise?  High pitched whine?  
I fix it with the following patch.

NeilBrown



Status: ok

Reduce HZ to 100

see if it affects noise..

 ----------- Diffstat output ------------
 ./include/asm-i386/param.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff ./include/asm-i386/param.h~current~ ./include/asm-i386/param.h
--- ./include/asm-i386/param.h~current~	2003-12-26 14:44:21.000000000 +1100
+++ ./include/asm-i386/param.h	2003-12-26 14:50:36.000000000 +1100
@@ -2,7 +2,7 @@
 #define _ASMi386_PARAM_H
 
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# define HZ		100		/* Internal kernel timer frequency */
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC	(USER_HZ)	/* like times() */
 #endif

