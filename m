Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVACPNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVACPNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 10:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVACPNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 10:13:51 -0500
Received: from holomorphy.com ([207.189.100.168]:28059 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261467AbVACPNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 10:13:44 -0500
Date: Mon, 3 Jan 2005 07:13:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1
Message-ID: <20050103151340.GW29332@holomorphy.com>
References: <20050103011113.6f6c8f44.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20050103011113.6f6c8f44.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 03, 2005 at 01:11:13AM -0800, Andrew Morton wrote:
> +m32r-fix-not-to-execute-noexec-pages-0-3.patch

This patch appears to be empty. Also, quilt barfs on such things.
The patch as it appeared in broken-out/ is attached.


-- wli

--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Description: m32r-fix-not-to-execute-noexec-pages-0-3.patch
Content-Disposition: attachment; filename="m32r-fix-not-to-execute-noexec-pages-0-3.patch"


From: Hirokazu Takata <takata@linux-m32r.org>

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

Signed-off-by: Andrew Morton <akpm@osdl.org>
---


_

--uAKRQypu60I7Lcqm--
