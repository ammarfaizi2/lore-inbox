Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263726AbTK2IWG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 03:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263728AbTK2IWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 03:22:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22797 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263726AbTK2IWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 03:22:03 -0500
Date: Sat, 29 Nov 2003 08:22:00 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: pZa1x <pZa1x@rogers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM Suspend Problem
Message-ID: <20031129082200.A30476@flint.arm.linux.org.uk>
Mail-Followup-To: pZa1x <pZa1x@rogers.com>, linux-kernel@vger.kernel.org
References: <3FC7F031.5060502@rogers.com> <3FC7F2E3.8080109@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FC7F2E3.8080109@rogers.com>; from pZa1x@rogers.com on Sat, Nov 29, 2003 at 01:14:11AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 01:14:11AM +0000, pZa1x wrote:
> A follow-up
> 
> by shutting down PCMCIA and rmmod'ing all the related modules ie ide_cs, 
> ds, yenta_socket, pcmcia_core the suspend works on AC again.
> 
> So, I add them back one by one:
> pcmcia_core -> still works
> yenta_socket -> FAILS!
> rmmod yenta_socket -> works again!
> 
> Summary: suspend works on my Thinkpad T21
> (a) with no apm module or apmd but with all PCMCIA (ie. hardware 
> suspend- close lid etc);
> (b) with apm & apmd and all PCMCIA but no AC power
> (c) with apm & apmd but no yenta_socket and the rest but with AC power
> 
> The problem is a combination of apm, yenta_socket and AC power.

The output of:

lspci -vvxxxx

both with and without yenta_socket inserted would be a useful starting
point.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
