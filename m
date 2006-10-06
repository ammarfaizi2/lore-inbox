Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422808AbWJFSN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422808AbWJFSN5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 14:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422810AbWJFSN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 14:13:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27289 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422808AbWJFSN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 14:13:56 -0400
Date: Fri, 6 Oct 2006 11:13:52 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Deepak Saxena <dsaxena@plexity.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-git] Fix ARM breakage due to no irq_regs.h
In-Reply-To: <20061006180755.GA31679@plexity.net>
Message-ID: <Pine.LNX.4.64.0610061112220.3952@g5.osdl.org>
References: <20061006180755.GA31679@plexity.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That should not really be nearly enough.

I've pushed out a more complete (but still untested) version that should 
hopefully be closer to fixing up any irq breakage on arm.

		Linus

On Fri, 6 Oct 2006, Deepak Saxena wrote:
> 
> diff --git a/include/asm-arm/irq_regs.h b/include/asm-arm/irq_regs.h
> new file mode 100644
> index 0000000..3dd9c0b
> --- /dev/null
> +++ b/include/asm-arm/irq_regs.h
> @@ -0,0 +1 @@
> +#include <asm-generic/irq_regs.h>
