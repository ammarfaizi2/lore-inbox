Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264071AbTEOPJU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 11:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTEOPIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 11:08:34 -0400
Received: from zero.aec.at ([193.170.194.10]:2061 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264071AbTEOPHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 11:07:49 -0400
Date: Thu, 15 May 2003 17:20:11 +0200
From: Andi Kleen <ak@muc.de>
To: Dave Jones <davej@codemonkey.org.uk>, Andi Kleen <ak@muc.de>,
       kraxel@suse.de, jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use MTRRs by default for vesafb on x86-64
Message-ID: <20030515152011.GA19271@averell>
References: <20030515145640.GA19152@averell> <20030515151633.GA6128@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515151633.GA6128@suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 05:16:33PM +0200, Dave Jones wrote:
> On Thu, May 15, 2003 at 04:56:40PM +0200, Andi Kleen wrote:
> 
>  > x86-64 cannot call the 32bit VESA BIOS. This means when vesafb is active
>  > it does software copying in the vesa frame buffer. This is insanely slow
>  > when the frame buffer is not marked for write combining. 
>  > 
>  > Some discussion showed that the use_mtrr flag was only off for some 
>  > old broken ET4000 ISA card. x86-64 has no ISA, so this is no concern.
>  > Make the default depend on CONFIG_ISA. 
> 
> There are PCI ET4000's too.  Though if we can get the PCI IDs for those,
> we can work around them with a quirk.  I have one *somewhere*, but it'll
> take me a while to dig it out.

To make all 0.001 users left of them happy yes. I think the patch should
be applied anyways.

-Andi
