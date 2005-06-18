Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVFRTJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVFRTJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 15:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVFRTJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 15:09:38 -0400
Received: from colin.muc.de ([193.149.48.1]:15122 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262199AbVFRTJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 15:09:26 -0400
Date: 18 Jun 2005 21:09:21 +0200
Date: Sat, 18 Jun 2005 21:09:21 +0200
From: Andi Kleen <ak@muc.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org, ACurrid@nvidia.com
Subject: Re: [2.6.12] x86-64 IO-APIC + timer doesn't work
Message-ID: <20050618190921.GA59126@muc.de>
References: <200506181452.52921.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506181452.52921.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2005 at 02:52:52PM +0100, Alistair John Strachan wrote:
> Hi,
> 
> I upgraded my nForce3 x86-64 desktop from 2.6.12-rc5 to 2.6.12 today and 
> something strange started happening. Waay back in 2.6.x I had problems with 
> the "noapic" default for nForce boards on x86-64, and so used the "apic" 
> kernel boot parameter to force the apic on; this worked successfully for a 
> long time with no timer problems.

apic hasn't been needed for several kernel releases now, since the
timer override problem on the Nforce has been workarounded.

> 
> However, as of 2.6.12 (maybe -rc6, too?) my desktop occasionally fails to boot 
> with the message:
> 
> "IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter."
> (arch/x86_64/kernel/io_apic.c)
> 
> However, this message is intermittent; it is sometimes possible to boot 
> without getting it, and everything works fine. So I took its advice and ran 
> with noapic, and everything seems fine now.
> 
> However, I just thought I'd let whoever maintains this bit of code know that 
> the check isn't a "sure thing": it's not being flagged reliably. Whether this 
> is my BIOS or the kernel, I don't know.
> 
> Though I clearly don't require this functionality any more, is there any 
> reason I now can't use apic on this nForce3 board, where previously (on 
> 2.6.12-rc5 and older) I could?

Are you sure the problem is new? 

Can you post the full output of a failing case with apic=verbose?

-Andi
