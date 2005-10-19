Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751596AbVJSWQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbVJSWQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbVJSWQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 18:16:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:35044 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751601AbVJSWQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 18:16:54 -0400
Subject: Re: [BUG] PDC20268 crashing during DMA setup on stock Debian
	2.6.12-1-powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <204AB9A8-7701-402F-A6B9-DF455DAA2A3F@mac.com>
References: <20051017005855.132266ac.akpm@osdl.org>
	 <1129536482.7620.76.camel@gaston>
	 <6DFB5723-0042-46FE-811F-BF372B068014@mac.com>
	 <204AB9A8-7701-402F-A6B9-DF455DAA2A3F@mac.com>
Content-Type: text/plain
Date: Thu, 20 Oct 2005 08:13:44 +1000
Message-Id: <1129760024.7620.219.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 13:48 -0400, Kyle Moffett wrote:
> Do you have any other ideas WRT this bug?  I've been browsing around  
> in the code a bit, and I plan to try diffing my 2.6.8.1 version of  
> the files against the latest Debian to see what changed, although I  
> suspect it will be a relatively fat hunk of changes.  Thanks for your  
> help!

Nope. The lspci output looks perfectly normal. I looks like a mixture of
issues with BM DMA being disabled for a reason I haven't figured out and
then the code crashing because it doesn't like BM-DMA being disabled ...

Again, best is you pour printk's all over setup-pci.c and ide-dma.c to
figure out what's going on...

Ben


