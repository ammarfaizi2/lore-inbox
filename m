Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVDDXeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVDDXeV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVDDXYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:24:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46315 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261501AbVDDXXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:23:24 -0400
Date: Mon, 4 Apr 2005 16:22:54 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       apw@shadowen.org
Subject: Re: [PATCH 1/4] create mm/Kconfig for arch-independent memory options
Message-ID: <20050404232254.GC6500@w-mikek2.ibm.com>
References: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 10:50:09AM -0700, Dave Hansen wrote:
diff -puN mm/Kconfig~A6-mm-Kconfig mm/Kconfig
--- memhotplug/mm/Kconfig~A6-mm-Kconfig 2005-04-04 09:04:48.000000000 -0700
+++ memhotplug-dave/mm/Kconfig  2005-04-04 10:15:23.000000000 -0700
@@ -0,0 +1,25 @@
> +choice
> +	prompt "Memory model"
> +	default FLATMEM
> +	default SPARSEMEM if ARCH_SPARSEMEM_DEFAULT
> +	default DISCONTIGMEM if ARCH_DISCONTIGMEM_DEFAULT
> +

Yet the changes to the defconfig files that had DISCONTIGMEM as
the default look like.

-CONFIG_DISCONTIGMEM=y
+CONFIG_ARCH_DISCONTIGMEM_ENABLE=y

Do you need to set ARCH_DISCONTIGMEM_DEFAULT instead of just
CONFIG_ARCH_DISCONTIGMEM_ENABLE to have DISCONTIGMEM be the
default? or am I missing something?  I don't see
ARCH_DISCONTIGMEM_DEFAULT turned on by default in any of these
patches.

-- 
Mike
