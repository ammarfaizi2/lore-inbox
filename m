Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbVDORat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbVDORat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 13:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVDORat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 13:30:49 -0400
Received: from colin2.muc.de ([193.149.48.15]:57351 "EHLO colin2.muc.de")
	by vger.kernel.org with ESMTP id S261851AbVDORam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 13:30:42 -0400
Date: 15 Apr 2005 19:30:40 +0200
Date: Fri, 15 Apr 2005 19:30:40 +0200
From: Andi Kleen <ak@muc.de>
To: Hariprasad Nellitheertha <hari@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][x86_64] Introducing the memmap= kernel command line option
Message-ID: <20050415173040.GK50241@muc.de>
References: <425F5BA3.3050001@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425F5BA3.3050001@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 11:43:55AM +0530, Hariprasad Nellitheertha wrote:
> Hi Andi,
> 
> In order to port kdump to x86_64, we need to have the 
> memmap= kernel command line option available. This is so 
> that the dump-capture kernel can be booted with a custom 
> memory map.
> 
> The attached patch adds the memmap= functionality to the 
> x86_64 kernel. It is against 2.6.12-rc2-mm3. I have done 
> some amount of testing and it is working fine.
> 
> Could you kindly review this patch and let me know your 
> thoughts on it.

You should add a __setup somewhere, otherwise the kernel
will complain about unknown arguments or generate a memmap
variable in inits environment. 

Comma parsing would be nice.

Otherwise it looks ok.

-Andi
