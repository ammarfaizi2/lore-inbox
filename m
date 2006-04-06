Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWDFBuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWDFBuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 21:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWDFBuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 21:50:51 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:31118 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751293AbWDFBuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 21:50:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KDyLx0vSDOtpzVxJ2KWvZh+jKxugg6nJGUO+M1bxS4gkhg9zS7jl6XbAsYPCUJrdOsh1QPq2qi0NTXhD0Kizi1Lqtzy7wCbjiVtjlGy8xgF1nxes+BlV1Nz/uI1iHZdqZq6B4zkXvPuPJ4lrTAFlHsi+5pCLhwTunu7gPhD++AQ=
Message-ID: <443473C3.4050807@gmail.com>
Date: Thu, 06 Apr 2006 09:49:55 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: "Luck, Tony" <tony.luck@intel.com>, Zou Nan hai <nanhai.zou@intel.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org
Subject: Re: 2.6.17-rc1-mm1
References: <20060404014504.564bf45a.akpm@osdl.org> <200604051015.34217.bjorn.helgaas@hp.com> <20060405211757.GA8536@agluck-lia64.sc.intel.com> <200604051601.08776.bjorn.helgaas@hp.com>
In-Reply-To: <200604051601.08776.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:
> On Wednesday 05 April 2006 15:17, Luck, Tony wrote:
>> On Wed, Apr 05, 2006 at 10:15:34AM -0600, Bjorn Helgaas wrote:

> [PATCH] vgacon: make VGA_MAP_MEM take size, remove extra use
> 
> VGA_MAP_MEM translates to ioremap() on some architectures.  It
> makes sense to do this to vga_vram_base, because we're going to
> access memory between vga_vram_base and vga_vram_end.
> 
> But it doesn't really make sense to map starting at vga_vram_end,
> because we aren't going to access memory starting there.  On ia64,
> which always has to be different, ioremapping vga_vram_end gives
> you something completely incompatible with ioremapped vga_vram_start,
> so vga_vram_size ends up being nonsense.
> 
> As a bonus, we often know the size up front, so we can use ioremap()
> correctly, rather than giving it a zero size.

I definitely prefer this patch.

> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Acked-by: Antonino Daplas <adaplas@pol.net>

Tony
