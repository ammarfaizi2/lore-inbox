Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUJNVUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUJNVUx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUJNVQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:16:52 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:44452 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266821AbUJNVPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:15:02 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: using cc-option in arch/ppc64/boot/Makefile
Date: Thu, 14 Oct 2004 16:11:32 +0000
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410141611.32198.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam, I would like to use "cc-option-yn" in arch/ppc64/boot/Makefile.

All recent 64-bit gcc/binutils can produce 32-bit code by passing -m32 (or 
similar) to them. arch/ppc64/boot/zImage is actually a 32-bit executable, and 
the Makefile still requires a separate 32-bit cross-compiler to build it (in 
addition to the 64-bit cross-compiler used for the vmlinux). To decide if 
$(CC) can handle -m32, I'd like to use cc-option-yn (as in 
arch/ppc64/Makefile).

I've tried moving the cc-option stuff out of the top-level Makefile into 
something that can be included from arch/ppc64/boot/Makefile, but so far the 
right magic has escaped me. Any ideas?

-- 
Hollis Blanchard
IBM Linux Technology Center
