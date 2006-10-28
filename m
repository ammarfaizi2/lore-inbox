Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752194AbWJ1MKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbWJ1MKn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 08:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752193AbWJ1MKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 08:10:43 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:47887 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752191AbWJ1MKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 08:10:42 -0400
Date: Sat, 28 Oct 2006 13:10:30 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: torvalds@osdl.org, akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       matthew@wil.cx, pavel@ucw.cz, shemminger@osdl.org
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
Message-ID: <20061028121030.GA29490@flint.arm.linux.org.uk>
Mail-Followup-To: "Adam J. Richter" <adam@yggdrasil.com>, torvalds@osdl.org,
	akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	matthew@wil.cx, pavel@ucw.cz, shemminger@osdl.org
References: <200610280823.k9S8NZ2D004392@freya.yggdrasil.com> <20061028092254.GA23461@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028092254.GA23461@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2006 at 10:22:54AM +0100, Russell King wrote:
> On Sat, Oct 28, 2006 at 04:23:35PM +0800, Adam J. Richter wrote:
> > 	This interface would have problems with nesting.
> 
> Adam (and the rest of the parallel crowd),
> 
> Just a passing thought (and nothing more)...
> 
> How does this behave with PCMCIA initialisation with a Cardbus card
> inserted?
> 
> This is one scenario which needs checking before any of this parallel
> probe code goes anywhere near mainline, since it's possible for the
> Cardbus (PCI) device to be added and therefore probed while the Yenta
> probe (PCI) is still running.

Can someone make sure Adam gets my email please?  His server rejects
messages from my domain:

  adam@yggdrasil.com
    SMTP error from remote mail server after MAIL FROM:<rmk+adam=yggdrasil.com@arm.linux.org.uk> SIZE=3022:
    host yggdrasil.com [61.49.148.168]: 553 5.1.8 <rmk+adam=yggdrasil.com@arm.linux.org.uk>... Domain of sender address rmk+adam=yggdrasil.com@arm.linux.org.uk does not exist

(the error is obviously utter rubbish.)

Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
