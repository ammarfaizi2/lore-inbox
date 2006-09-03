Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750904AbWICWJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbWICWJq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 18:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWICWJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 18:09:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:25868 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932174AbWICWJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 18:09:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DaxGQHfbNw0qbpZ+fMH5IP6zcxuQ7FyT4pBRgwaSm4me6kANCbQuEgfDnFFStQsLtY1rV+9UPSHouzXDmre13LA871DVR3g25zHJ7fDUolz0ocQcW2CRjvUKC7ELHRf3KSVk2WjQZJiRXcunhjOvNAiEUCRjFJOFb/4W7C4MbO0=
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: [PATCH 18/26] Dynamic kernel command-line - s390
Date: Mon, 4 Sep 2006 01:00:30 +0300
User-Agent: KMail/1.9.4
Cc: Matt Domsch <Matt_Domsch@dell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, johninsd@san.rr.com,
       davej@codemonkey.org.uk, Riley@williams.name, trini@kernel.crashing.org,
       davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org, wli@holomorphy.com, lethal@linux-sh.org, rc@rc0.org.uk,
       spyro@f2s.com, rth@twiddle.net, avr32@atmel.com, hskinnemoen@atmel.com,
       starvik@axis.com, ralf@linux-mips.org, matthew@wil.cx,
       grundler@parisc-linux.org, geert@linux-m68k.org, zippel@linux-m68k.org,
       paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
References: <200609040050.13410.alon.barlev@gmail.com>
In-Reply-To: <200609040050.13410.alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609040100.34138.alon.barlev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rename saved_command_line into boot_command_line.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

diff -urNp linux-2.6.18-rc5-mm1.org/arch/s390/kernel/setup.c 
linux-2.6.18-rc5-mm1/arch/s390/kernel/setup.c
--- linux-2.6.18-rc5-mm1.org/arch/s390/kernel/setup.c	
2006-09-03 18:56:51.000000000 +0300
+++ linux-2.6.18-rc5-mm1/arch/s390/kernel/setup.c	2006-09-03 
19:47:58.000000000 +0300
@@ -626,7 +626,7 @@ setup_arch(char **cmdline_p)
 #endif /* CONFIG_64BIT */
 
 	/* Save unparsed command line copy for /proc/cmdline */
-	strlcpy(saved_command_line, COMMAND_LINE, 
COMMAND_LINE_SIZE);
+	strlcpy(boot_command_line, COMMAND_LINE, 
COMMAND_LINE_SIZE);
 
 	*cmdline_p = COMMAND_LINE;
 	*(*cmdline_p + COMMAND_LINE_SIZE - 1) = '\0';

-- 
VGER BF report: H 0.448735
