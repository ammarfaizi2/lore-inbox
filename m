Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272252AbTHIEyn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 00:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272255AbTHIEyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 00:54:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:7886 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S272252AbTHIEym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 00:54:42 -0400
Date: Sat, 09 Aug 2003 00:53:40 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH]  2.4.22-rc1-ac1: Unused variable in arch/i386/kernel/setup.c
 if CONFIG_SMP is not defined
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <3F347E54.6010107@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_k1SGeP5DX/ZqM+lP1pMxpA)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_k1SGeP5DX/ZqM+lP1pMxpA)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Folks,

    this patch fixes a compile warning about an unused variable in 
arch/i386/kernel/setup.c if CONFIG_SMP is not defined.

    The patch applies to 2.4.22-rc1-ac1.

Stephane Ouellette


--Boundary_(ID_k1SGeP5DX/ZqM+lP1pMxpA)
Content-type: text/plain; name=setup.c-2.4.22-rc1-ac1.diff; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=setup.c-2.4.22-rc1-ac1.diff

--- linux-2.4.22-rc1-ac1-orig/arch/i386/kernel/setup.c	Fri Aug  8 22:34:38 2003
+++ linux-2.4.22-rc1-ac1-fixed/arch/i386/kernel/setup.c	Sat Aug  9 00:41:01 2003
@@ -2978,7 +2978,9 @@
 	 * applications want to get the raw CPUID data, they should access
 	 * /dev/cpu/<cpu_nr>/cpuid instead.
 	 */
+#ifdef CONFIG_SMP
 	extern	int phys_proc_id[NR_CPUS];
+#endif
 	static char *x86_cap_flags[] = {
 		/* Intel-defined */
 	        "fpu", "vme", "de", "pse", "tsc", "msr", "pae", "mce",

--Boundary_(ID_k1SGeP5DX/ZqM+lP1pMxpA)--
