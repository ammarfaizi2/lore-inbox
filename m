Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbULJSU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbULJSU1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbULJSU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:20:26 -0500
Received: from holomorphy.com ([207.189.100.168]:58002 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261791AbULJSUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:20:13 -0500
Date: Fri, 10 Dec 2004 10:19:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210181954.GU2714@holomorphy.com>
References: <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random> <20041203022854.GL32635@dualathlon.random> <20041210163614.GN2714@holomorphy.com> <20041210173554.GW16322@dualathlon.random> <20041210174336.GP2714@holomorphy.com> <20041210175504.GY16322@dualathlon.random> <20041210180031.GT2714@holomorphy.com> <20041210181529.GZ16322@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210181529.GZ16322@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 10:00:31AM -0800, William Lee Irwin III wrote:
>> Yet those don't appear in the tasklist, so some task in the tasklist
>> has to get ->mm set to &init_mm. The notion above was that the init_mm
>> check was to handle some out-of-tree attempt to do aio from kernel threads.

On Fri, Dec 10, 2004 at 07:15:29PM +0100, Andrea Arcangeli wrote:
> Not sure to understand correctly but, aio has always been done through
> kernel threads, and that's the whole thing about aio. Not sure what
> you're doing out-of-tree, but you don't need to use init_mm to deal with
> kernel threads, infact kernel threads can only have ->mm = NULL. When
> switching mm with use_mm the aio thread is only going to use a real mm
> with mappings in userspace, so even in that case you don't need init_mm.
> I didn't see the out of tree code though.

Maybe the whole init_mm check should die since nothing in-tree could
cause it?


-- wli
