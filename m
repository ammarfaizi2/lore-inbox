Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWAIQlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWAIQlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWAIQlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:41:47 -0500
Received: from colin.muc.de ([193.149.48.1]:2319 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751214AbWAIQlp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:41:45 -0500
Date: 9 Jan 2006 17:41:40 +0100
Date: Mon, 9 Jan 2006 17:41:40 +0100
From: Andi Kleen <ak@muc.de>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HPET RTC emulation: add watchdog timer
Message-ID: <20060109164140.GA67021@muc.de>
References: <20060109154350.GA22126@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109154350.GA22126@turing.informatik.uni-halle.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 04:43:50PM +0100, Clemens Ladisch wrote:
> To prevent the emulated RTC timer from stopping when interrupts are
> disabled for too long, implement the watchdog timer to restart it when
> needed.

The interrupt handler should just read the time (it likely
has to do that anyways) and check for that
directly. That is what I did in my noidletick HPET patch and it 
worked ok.

-Andi
