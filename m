Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263249AbVFXLb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263249AbVFXLb5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 07:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263255AbVFXLb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 07:31:57 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:26133 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263249AbVFXLb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 07:31:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=YH3LTTPV7WK9Oijf7Rq2cHmnBbvHI4LOh7VgKvEuEBv0mO8qhMG1+pv0YCogFKRUFaGrLuG1xe3ii+qFJRrXQArp1SiXz5kwrrY8KL9+HsxBexooODtBMWSjDiXC534fGUaS7pVW4mnwam59zHb55KuEVM6H0Yrefw5k50XbHGk=
Date: Fri, 24 Jun 2005 19:32:13 +0800
From: Alecs King <alecsk@gmail.com>
To: git@vger.kernel.org
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Finding what change broke ARM
Message-ID: <20050624113213.GA2328@loalhost.H.qngy.gscas>
Mail-Followup-To: git@vger.kernel.org,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20050624101951.B23185@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624101951.B23185@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 10:19:51AM +0100, Russell King wrote:
> When building current git for ARM, I see:
> 
>   CC      arch/arm/mm/consistent.o
> arch/arm/mm/consistent.c: In function `dma_free_coherent':
> arch/arm/mm/consistent.c:357: error: `mem_map' undeclared (first use in this function)
> arch/arm/mm/consistent.c:357: error: (Each undeclared identifier is reported only once
> arch/arm/mm/consistent.c:357: error: for each function it appears in.)
> make[2]: *** [arch/arm/mm/consistent.o] Error 1
> 
> How can I find what change elsewhere in the kernel tree caused this
> breakage?
> 
> With bk, you could ask for a per-file revision history of the likely
> candidates, and then find the changeset to view the other related
> changes.
> 
> With git... ?  We don't have per-file revision history so...

Wouldnt a 'git-whatchanged -p <candidates>' help?


-- 
Alecs King
