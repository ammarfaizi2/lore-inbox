Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbUANJck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUANJck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:32:40 -0500
Received: from colin2.muc.de ([193.149.48.15]:29715 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266101AbUANJ3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:29:35 -0500
Date: 14 Jan 2004 10:30:31 +0100
Date: Wed, 14 Jan 2004 10:30:31 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-ID: <20040114093031.GA19652@colin2.muc.de>
References: <20040114090603.GA1935@averell> <20040114091630.A14739@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114091630.A14739@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 09:16:30AM +0000, Russell King wrote:
> On Wed, Jan 14, 2004 at 10:06:03AM +0100, Andi Kleen wrote:
> > Using -mregparm=3 shrinks the kernel further:
> 
> Note that there is a dependence on this patch - as highlighted by Arjan,
> CardServices() breaks when built on x86 with -mregparm.
> 
> Therefore, the CardServices() patches need to be merged into any tree
> prior to this patch.

Ah, because of the broken prototypes again? 

You could just mark them all asmlinkage to force stack arguments.

Or just fix the prototypes.

-Andi
