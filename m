Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265226AbUGCSs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265226AbUGCSs7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 14:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbUGCSs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 14:48:59 -0400
Received: from holomorphy.com ([207.189.100.168]:18117 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265226AbUGCSs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 14:48:56 -0400
Date: Sat, 3 Jul 2004 11:48:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: 4K vs 8K stacks- Which to use?
Message-ID: <20040703184849.GS21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Justin Piszcz <jpiszcz@lucidpixels.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0407031038310.32173-100000@coffee.psychology.mcmaster.ca> <Pine.LNX.4.60.0407031043070.13543@p500>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0407031043070.13543@p500>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jul 2004, Mark Hahn wrote:
>> why do you think it would be processor-specific?

On Sat, Jul 03, 2004 at 10:44:44AM -0400, Justin Piszcz wrote:
> Well I know IA32 is limited to a 4096 byte page size in the Linux Kernel; 
> hence filesystems can only use 4KB blocks on IA32, therefore I was 
> wondering if anything might change in 64bit land?

64-bit ports tend to have stacks around twice the native pagesize, e.g.
sparc64 has 16K stacks and 8K pages, similar to 32-bit ports, except for
ia64. The ia32 port has adopted the order 0 stacksize in the interest
of space savings relatively early among Linux ports. It would be nice
to get the same for all architectures, as higher-order allocations are
not good to have as anything but speculative (and obviously stacks are
not variable-sized) for reasons of fragmentation.


-- wli
