Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVFVRcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVFVRcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 13:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVFVR3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 13:29:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44561 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261800AbVFVRXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 13:23:02 -0400
Date: Wed, 22 Jun 2005 18:22:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: "Eugeny S. Mints" <emints@ru.mvista.com>,
       Andrew Lewis <andrew-lewis@netspace.net.au>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: ARM Linux Suitability for Real-time Application
Message-ID: <20050622182250.A13976@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Walker <dwalker@mvista.com>,
	"Eugeny S. Mints" <emints@ru.mvista.com>,
	Andrew Lewis <andrew-lewis@netspace.net.au>,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20050622100231.A28181@flint.arm.linux.org.uk> <Pine.LNX.4.10.10506220951190.455-100000@godzilla.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.10.10506220951190.455-100000@godzilla.mvista.com>; from dwalker@mvista.com on Wed, Jun 22, 2005 at 09:52:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 09:52:40AM -0700, Daniel Walker wrote:
> On Wed, 22 Jun 2005, Russell King wrote:
> > If you're just after some background process to run off interrupts with
> > minimal interrupt latency, the good news is that you don't have to modify
> > the kernel on ARM, and you certainly don't need any RT patches.
> > 
> > If you use the FIQ, then your FIQ latency will be the time it takes the
> > CPU to enter your FIQ function.  Since the kernel _never_ disables FIQs
> > in any way, FIQs have ultimate priority over everything else in the
> > system.
> > 
> 
> Aren't FIQ's only on some ARM's ? 

Yes, but please read the original mail.  I think you'll find my reply
is completely relevant to the question being posed, which was based
upon the AT91RM9200 SoC.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
