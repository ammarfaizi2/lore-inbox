Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262671AbTCPO3Y>; Sun, 16 Mar 2003 09:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262672AbTCPO3Y>; Sun, 16 Mar 2003 09:29:24 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:6151 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S262671AbTCPO3X>; Sun, 16 Mar 2003 09:29:23 -0500
Subject: Re: [patch] NUMAQ subarchification
From: James Bottomley <James.Bottomley@steeleye.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0303152353520.10374-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0303152353520.10374-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 16 Mar 2003 08:36:51 -0600
Message-Id: <1047825416.4371.6.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 23:55, Kai Germaschewski wrote:
> On 15 Mar 2003, James Bottomley wrote:
> +config X86_DEFAULT_TOPOLOGY
> +	bool
> +	default y
> +	depends on X86_PC || X86_NUMAQ || X86_SUMMIT || X86_BIGSMP
> +

The slight problem here is that topology isn't shared between default,
summit and numaq (or at least won't be when the #ifdef mess is removed
from the default), but summit and numaq would still like to share the
same topology file between them, which is going to add another level of
complexity to the Makefile solution.

On the whole, I think the least of the three evils is #including a .c
file.

James


