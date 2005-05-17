Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVEQNpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVEQNpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 09:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVEQNpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 09:45:12 -0400
Received: from users.ccur.com ([208.248.32.211]:33761 "EHLO gamx.iccur.com")
	by vger.kernel.org with ESMTP id S261175AbVEQNpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 09:45:05 -0400
Date: Tue, 17 May 2005 09:44:34 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Christoph Lameter <christoph@lameter.com>
Cc: Linus Torvalds <torvalds@osdl.org>, randy_dunlap <rdunlap@xenotime.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, shai@scalex86.org,
       ak@suse.de
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-ID: <20050517134434.GA26822@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw> <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net> <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net> <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org> <Pine.LNX.4.62.0505162225260.28022@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505162225260.28022@graphe.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 10:31:25PM -0700, Christoph Lameter wrote:
> +	help
> +	  100 HZ is a typical choice for servers, SMP and NUMA systems
> +	  with lots of processors that may show reduced performance if
> +	  too many timer interrupts are occurring.

One of the options should mention the power savings benefit on laptops.
How about:

	help

	  100 HZ, the lowest setting, is the best choice for any system
	  where the servicing of interrupts is expensive.  This includes:
	  systems with so many processors that the mere execution of timer
	  interrupts on each and every processor degrades performance,
	  virtual systems, where Linux is not running on bare hardware
	  but is instead a guest operating system running on top of a
	  virtualization layer, and laptops, where each interrupt causes
	  a processor that is in low power mode to power up in order
	  to service the interrupt, and after the interrupt is complete,
	  might take up to one millisecond to power back down again.

Regards,
Joe
--
"Money can buy bandwidth, but latency is forever" -- John Mashey
