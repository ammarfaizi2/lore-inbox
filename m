Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbULJRoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbULJRoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbULJRoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:44:04 -0500
Received: from holomorphy.com ([207.189.100.168]:32402 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261769AbULJRn7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:43:59 -0500
Date: Fri, 10 Dec 2004 09:43:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210174336.GP2714@holomorphy.com>
References: <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random> <20041203022854.GL32635@dualathlon.random> <20041210163614.GN2714@holomorphy.com> <20041210173554.GW16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210173554.GW16322@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 08:36:14AM -0800, William Lee Irwin III wrote:
>> Maybe the mm == &init_mm case should return an ERR_PTR also, as that is
>> a sign of a transient error, not cause for a hard panic.

On Fri, Dec 10, 2004 at 06:35:54PM +0100, Andrea Arcangeli wrote:
> It can't be a transient error as far as I can tell, it's just like the
> issue of alloc_pages returning NULL (and potentially scheduling first)
> before mounting the root fs.

Well, the only way I see this happening is the process exiting followed
by use_mm() on init_mm for unobvious reasons (perhaps reasons not in
the tree).


-- wli
