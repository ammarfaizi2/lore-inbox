Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265223AbTFSMPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265291AbTFSMPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:15:41 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:54995 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S265223AbTFSMPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:15:40 -0400
Date: Thu, 19 Jun 2003 18:00:16 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.72-mm2
Message-ID: <20030619123015.GH1204@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030619013311.5deb37c0.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030619013311.5deb37c0.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 08:33:57AM +0000, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.72/2.5.72-mm2/
> 

I needed this to compile without warnings for copy_from_user


diff -puN include/asm-i386/uaccess.h~copy_from_user-inc-fix include/asm-i386/uaccess.h
--- linux-2.5.72-mm2/include/asm-i386/uaccess.h~copy_from_user-inc-fix	2003-06-19 17:56:16.000000000 +0530
+++ linux-2.5.72-mm2-maneesh/include/asm-i386/uaccess.h	2003-06-19 17:56:43.000000000 +0530
@@ -9,6 +9,7 @@
 #include <linux/thread_info.h>
 #include <linux/prefetch.h>
 #include <asm/page.h>
+#include <asm/string.h>
 
 #define VERIFY_READ 0
 #define VERIFY_WRITE 1

_

Regards,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
