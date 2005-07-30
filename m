Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263074AbVG3Ry2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263074AbVG3Ry2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 13:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVG3Ry2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 13:54:28 -0400
Received: from fsmlabs.com ([168.103.115.128]:12264 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S263074AbVG3Ry0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 13:54:26 -0400
Date: Sat, 30 Jul 2005 11:59:40 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Zachary Amsden <zach@vmware.com>
cc: Pavel Machek <pavel@ucw.cz>, akpm@osdl.org, chrisl@vmware.com,
       davej@codemonkey.org.uk, hpa@zytor.com, linux-kernel@vger.kernel.org,
       pratap@vmware.com, Riley@Williams.Name
Subject: Re: [PATCH] 2/6 i386 serialize-msr
In-Reply-To: <42EBBC43.3080803@vmware.com>
Message-ID: <Pine.LNX.4.61.0507301157530.29844@montezuma.fsmlabs.com>
References: <200507300404.j6U44GSC005922@zach-dev.vmware.com>
 <20050730103207.GD1942@elf.ucw.cz> <42EBBC43.3080803@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
-	__asm__ __volatile__ ("cpuid" : : : "ax", "bx", "cx", "dx");
+	/* see 1.07.  Apprent chip bug */
+	serialize_cpu(); 

1.07 in which document? Also, please just spell 'apparent' correctly, 
saving 1 byte really just looks lazy.
