Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbULPMlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbULPMlS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 07:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbULPMlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 07:41:18 -0500
Received: from mail.renesas.com ([202.234.163.13]:22409 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261931AbULPMlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 07:41:14 -0500
Date: Thu, 16 Dec 2004 21:41:00 +0900 (JST)
Message-Id: <20041216.214100.278750319.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Fix not to execute noexec pages (0/3)
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patchset to fix a bug of m32r kernel 2.6.9 that a code on
a noexec page can be executed incorrectly.

For good security, stack region should be non-executable. 
This fix is also needed to achieve non-executable stack.

Please apply this to 2.6.10 kernel if possible.

Thank you.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

[PATCH 2.6.10-rc3-mm1] m32r: Cause SIGSEGV for nonexec page execution (1/3)
- Cause a segmentation fault for an illegal execution of a code on
  non-executable memory page.

[PATCH 2.6.10-rc3-mm1] m32r: Don't encode ACE_INSTRUCTION in address (2/3)
- To be more comprehensive, keep ACE_INSTRUCTION (access exception 
  on instruction execution) information in thread_info->flags,
  instead of encoding it into address parameter.

[PATCH 2.6.10-rc3-mm1] m32r: Clean up arch/m32r/mm/fault.c (3/3)
- Fix a typo: ACE_USEMODE --> ACE_USERMODE.
- Update copyright statement, and so on.

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
