Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267320AbUHDPub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267320AbUHDPub (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 11:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267319AbUHDPua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 11:50:30 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:36429 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S267316AbUHDPuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 11:50:12 -0400
Subject: Re: [PATCH] ppc32: fix mktree utility in 64-bit cross-compile
	environment
From: Hollis Blanchard <hollisb@us.ibm.com>
To: "Zink, Dan" <dan.zink@hp.com>
Cc: akpm@osdl.org, linuxppc-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <8C91B010B3B7994C88A266E1A72184D306BEFD8F@cceexc19.americas.cpqcorp.net>
References: <8C91B010B3B7994C88A266E1A72184D306BEFD8F@cceexc19.americas.cpqcorp.net>
Content-Type: text/plain
Message-Id: <1091634312.24091.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Aug 2004 10:45:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-03 at 17:01, Zink, Dan wrote:
> --- arch/ppc/boot/utils/mktree.c.old	2004-08-03 16:31:09.568992888
> -0500
> +++ arch/ppc/boot/utils/mktree.c	2004-08-03 16:32:26.773256056
> -0500
> @@ -15,19 +15,20 @@
>  #include <sys/stat.h>
>  #include <unistd.h>
>  #include <netinet/in.h>
> +#include <asm/types.h>

You'll notice we don't include any other <asm/*> headers; this tool can
be built standalone.

Is there a reason not to use <stdint.h> and uint32_t?

-- 
Hollis Blanchard
IBM Linux Technology Center

