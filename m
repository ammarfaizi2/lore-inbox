Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUJ2U1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUJ2U1o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263498AbUJ2UXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:23:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38662 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263443AbUJ2UUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:20:34 -0400
Date: Fri, 29 Oct 2004 21:20:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tim_T_Murphy@Dell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP kernel
Message-ID: <20041029212029.I31627@flint.arm.linux.org.uk>
Mail-Followup-To: Tim_T_Murphy@Dell.com, linux-kernel@vger.kernel.org
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC4@ausx2kmps304.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4B0A1C17AA88F94289B0704CFABEF1AB0B4CC4@ausx2kmps304.aus.amer.dell.com>; from Tim_T_Murphy@Dell.com on Fri, Oct 29, 2004 at 02:55:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 02:55:10PM -0500, Tim_T_Murphy@Dell.com wrote:
> I've read about several problems others are having with the new 2.6
> serial driver in the list, and tried to see if their solutions solved
> my issue also, but unfortunately none that I have tried yet have helped.

Well, this is the first I know of this kind of problem...

> We're migrating our applications for the Dell Remote Access Controller
> (DRAC) to run on a 2.6 kernel from a 2.4 kernel. Communication between
> the apps and the DRAC happen over a ppp link which is established via
> a service startup script; the script uses setserial to prepare an unused
> tty (based on the assigned hardware information, obtained via lspci),
> and the script then calls pppd to finish/establish the link.

Shouldn't 8250_pci setup the ports already for you?  If not, what needs
to be done to achieve this.  Using setserial to setup ports for PCI cards
isn't the preferred way of doing this.

At a guess, you've enabled "low latency" setting on this port ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
