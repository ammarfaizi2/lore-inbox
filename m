Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbTIEBsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbTIEBsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:48:53 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:30387 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261586AbTIEBsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:48:52 -0400
Subject: Re: [RFC] NR_CPUS=8 on a 32 cpu box
From: Dave Hansen <haveblue@us.ibm.com>
To: John Stultz <johnstul@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
In-Reply-To: <1062725220.1307.1562.camel@cog.beaverton.ibm.com>
References: <1062725220.1307.1562.camel@cog.beaverton.ibm.com>
Content-Type: multipart/mixed; boundary="=-PX8NHk5E3MIUELnBfKqE"
Organization: 
Message-Id: <1062726472.32000.13.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Sep 2003 18:47:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PX8NHk5E3MIUELnBfKqE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2003-09-04 at 18:27, john stultz wrote:
> Let me know if you have any comments or suggestions. 

While you're at it, can we do this as well?  10 bucks says we'll keep
hitting this otherwise.  I think Bill can manage to remember to change
it if he tries for a 64x NUMA-Q.  The rest of us are too stupid most of
the time.

-- 
Dave Hansen
haveblue@us.ibm.com

--=-PX8NHk5E3MIUELnBfKqE
Content-Disposition: attachment; filename=nr_cpus_kconfig-2.6.0-test4+bk-0.patch
Content-Type: text/plain; name=nr_cpus_kconfig-2.6.0-test4+bk-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- linux-2.5/arch/i386/Kconfig.orig	Thu Sep  4 18:41:05 2003
+++ linux-2.5/arch/i386/Kconfig	Thu Sep  4 18:46:44 2003
@@ -451,6 +451,7 @@
 config NR_CPUS
 	int "Maximum number of CPUs (2-255)"
 	depends on SMP
+	default "32" if X86_NUMAQ || X86_SUMMIT || X86_BIGSMP || X86_ES7000
 	default "8"
 	help
 	  This allows you to specify the maximum number of CPUs which this

--=-PX8NHk5E3MIUELnBfKqE--

