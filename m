Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273888AbRJEWCw>; Fri, 5 Oct 2001 18:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274194AbRJEWCn>; Fri, 5 Oct 2001 18:02:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:42401 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S273888AbRJEWC2>; Fri, 5 Oct 2001 18:02:28 -0400
Date: Fri, 05 Oct 2001 14:58:31 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Alessandro Suardi <alessandro.suardi@oracle.com>,
        Dan Merillat <harik@chaos.ao.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Wierd /proc/cpuinfo with 2.4.11-pre4
Message-ID: <1566531237.1002293911@mbligh.des.sequent.com>
In-Reply-To: <3BBE29DF.A5DECF12@oracle.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Wow!  That's pretty impressive, a new kernel build gives me an
>> additional _7_ CPUs!

Sorry. Mea culpa

--- setup.c.old	Fri Oct  5 14:20:29 2001
+++ setup.c	Fri Oct  5 14:28:51 2001
@@ -2420,7 +2420,7 @@
 	 * WARNING - nasty evil hack ... if we print > 8, it overflows the
 	 * page buffer and corrupts memory - this needs fixing properly
 	 */
-	for (n = 0; n < 8; n++, c++) {
+	for (n = 0; n < (clustered_apic_mode ? 8 : NR_CPUS); n++, c++) {
 	/* for (n = 0; n < NR_CPUS; n++, c++) { */
 		int fpu_exception;
 #ifdef CONFIG_SMP

M.

PS. I just tested this since my last post. It seems to work.

