Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRCHUo6>; Thu, 8 Mar 2001 15:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129609AbRCHUos>; Thu, 8 Mar 2001 15:44:48 -0500
Received: from h55p103-2.delphi.afb.lu.se ([130.235.187.175]:57800 "EHLO
	burton") by vger.kernel.org with ESMTP id <S129598AbRCHUog>;
	Thu, 8 Mar 2001 15:44:36 -0500
Date: Thu, 8 Mar 2001 21:43:13 +0100
To: Greg KH <greg@wirex.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac14
Message-ID: <20010308214313.A22539@h55p111.delphi.afb.lu.se>
In-Reply-To: <E14an7j-0001rZ-00@the-village.bc.nu> <20010307164052.B788@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010307164052.B788@wirex.com>; from greg@wirex.com on Wed, Mar 07, 2001 at 04:40:52PM -0800
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2001 at 04:40:52PM -0800, Greg KH wrote:

> > o	Fix the non build problem with do_BUG		(Andrew Morton)

> i386_ksyms.c:170: `do_BUG' undeclared here (not in a function)

> # CONFIG_DEBUG_BUGVERBOSE is not set

this patch makes it _compile_ both with and without BUGVERBOSE.

-- 

//anders/g

--- arch/i386/kernel/i386_ksyms.c.orig  Thu Mar  8 21:30:27 2001
+++ arch/i386/kernel/i386_ksyms.c       Thu Mar  8 21:30:31 2001
@@ -167,5 +167,7 @@
 EXPORT_SYMBOL(empty_zero_page);
 #endif

+#ifdef CONFIG_DEBUG_BUGVERBOSE
 EXPORT_SYMBOL(do_BUG);
+#endif
   
   
