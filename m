Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWARUlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWARUlS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWARUlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:41:18 -0500
Received: from uproxy.gmail.com ([66.249.92.194]:42207 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030429AbWARUlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:41:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=uPAsEj280X9Wo9HnZi24zbMQeeOncC7hzcqB3RLHQWveBp1fGLYb3co7ZdCYdEd7achiYVOowbbG0W5m4VNFsej4x1CzML1P4ZtZfMeDtFDc1xSqqzCZx5NhwUSV2ob+rZ37OBwYGasmgguyUcNo03u82I1xtriricCYVbUhBlc=
Date: Wed, 18 Jan 2006 23:58:42 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: select system type via "choice"
Message-ID: <20060118205842.GD12771@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Choosing ARCH_ARC and ARCH_A5K together causes redefining and errors
here and there.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/arm26/Kconfig |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

--- a/arch/arm26/Kconfig
+++ b/arch/arm26/Kconfig
@@ -60,7 +60,8 @@ source "init/Kconfig"
 
 menu "System Type"
 
-comment "Archimedes/A5000 Implementations (select only ONE)"
+choice
+	prompt "Archimedes/A5000 Implementations"
 
 config ARCH_ARC
         bool "Archimedes"
@@ -87,6 +88,7 @@ config PAGESIZE_16
           Say Y here if your Archimedes or A5000 system has only 2MB of
           memory, otherwise say N.  The resulting kernel will not run on a
           machine with 4MB of memory.
+endchoice
 endmenu
 
 config ISA_DMA_API

