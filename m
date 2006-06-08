Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWFHPJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWFHPJE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 11:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWFHPJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 11:09:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:35771 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964859AbWFHPJC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 11:09:02 -0400
Message-ID: <44883C68.8010307@in.ibm.com>
Date: Thu, 08 Jun 2006 20:34:08 +0530
From: Suzuki <suzuki@in.ibm.com>
Organization: IBM Software Labs
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm@osdl.org
Subject: Fix Compilation error for UM Linux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch fixes the compilation error for UM Linux with linux-2.6.17-rc5.

It complains of using (void *) in arithmetic.

Thanks.

Suzuki K P
Linux Technology Center,
IBM Software Labs.



* Fix the compilation error for um-linux.

Signed Off by: Suzuki K P <suzuki@in.ibm.com>

--- arch/um/include/mem.h       2006-05-25 01:45:04.000000000 -0700
+++ arch/um/include/mem.h~fix_compilation_error 2006-06-08 
07:46:21.000000000 -0700
@@ -22,7 +22,7 @@ static inline unsigned long to_phys(void

  static inline void *to_virt(unsigned long phys)
  {
-       return((void *) uml_physmem + phys);
+       return (void *) (uml_physmem + phys);
  }

  #endif


