Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVJ1VhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVJ1VhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 17:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVJ1VhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 17:37:09 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1299 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750763AbVJ1VhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 17:37:08 -0400
Date: Fri, 28 Oct 2005 22:36:51 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, Hugh Dickins <hugh@veritas.com>,
       Andi Kleen <ak@suse.de>, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Message-ID: <20051028213651.GA24432@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Lee Revell <rlrevell@joe-job.com>, Hugh Dickins <hugh@veritas.com>,
	Andi Kleen <ak@suse.de>, vojtech@suse.cz, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <200510271026.10913.ak@suse.de> <20051028072003.GB1602@openzaurus.ucw.cz> <Pine.LNX.4.61.0510281947040.5112@goblin.wat.veritas.com> <1130532239.4363.125.camel@mindpipe> <20051028205132.GB11397@elf.ucw.cz> <20051028205916.GL4464@flint.arm.linux.org.uk> <20051028212305.GA2447@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028212305.GA2447@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 11:23:05PM +0200, Pavel Machek wrote:
> > Having a TP 380XD which regularly produces this annoying message,
> > it's just logspam.  There's no noticable failure.
> 
> I do notice lost keys on x32 here. You need to press some weird
> combination...

I don't need any weird combinations to produce this message - it
appears quite often when hitting keys to wake it up from sleep
mode (which it has an eager desire to be in when it's used in
text-only mode.)

> > What do you suggest?
> 
> Well, having error counter for each input device would probably be
> enough. Or perhaps add some rate-limiting. One message per boot should
> be adequate.

$ dmesg |grep 'too many' | wc -l
72

I don't care how many occur or even that they do occur.  That's not
to say someone else doesn't.  But if there is someone else who does
care, maybe they should speak up and produce a patch to add whatever
/they/ /do/ require.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
