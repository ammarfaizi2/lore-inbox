Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751965AbWCFJEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbWCFJEg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbWCFJEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:04:35 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34206 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751965AbWCFJEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:04:35 -0500
Date: Mon, 6 Mar 2006 01:02:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: J M Cerqueira Esteves <jmce@artenumerica.com>
Cc: linux-kernel@vger.kernel.org, support@artenumerica.com, ngalamba@fc.ul.pt,
       axboe@suse.de, "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: oom-killer: gfp_mask=0xd1 with 2.6.15.4 on EM64T [previously
 2.6.12]
Message-Id: <20060306010241.2c230379.akpm@osdl.org>
In-Reply-To: <440BF718.60504@artenumerica.com>
References: <4405D383.5070201@artenumerica.com>
	<20060302011735.55851ca2.akpm@osdl.org>
	<440865A9.4000102@artenumerica.com>
	<4409B8DC.9040404@artenumerica.com>
	<20060304161519.6e6fbe2c.akpm@osdl.org>
	<440BF718.60504@artenumerica.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J M Cerqueira Esteves <jmce@artenumerica.com> wrote:
>
> Andrew Morton wrote:
> > We have a candidate fix at
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/x86_64-mm-blk-bounce.patch.
> >  Could you test that?  (and don't alter the Cc: list!).  The patch is
> > against 2.6.16-rc5.
> 
> Testing that kernel now, with good news: the machine has been apparently
> stable, running Gaussian processes for the last 20 hours, with no
> oom-killer messages.

OK, thanks.  The first iteration of that patch caused ia64 to go BUG, so we
took the BUG out.  We're calling init_emergency_isa_pool() on ia64 which
seems rather silly.  So my confidence level in that patch remains low, and
our need for it is high.

> A new "feature": 36 of these kernel message pairs as boot time:
>   device-mapper: dm-linear: Device lookup failed
>   device-mapper: error adding target to table
> 

OK, there were some fairly large DM patches touching on
dm_get_device().  Cc added ;)

