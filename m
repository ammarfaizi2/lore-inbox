Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTILX0U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTILX0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:26:19 -0400
Received: from [65.248.4.67] ([65.248.4.67]:8632 "EHLO verdesmares.com")
	by vger.kernel.org with ESMTP id S261970AbTILX0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:26:05 -0400
Message-ID: <011301c37963$858dece0$f8e4a7c8@bsb.virtua.com.br>
From: "Breno" <brenosp@brasilsec.com.br>
To: "William Lee Irwin III" <wli@holomorphy.com>,
       "Kernel List" <linux-kernel@vger.kernel.org>
References: <002b01c37956$d88d67c0$f8e4a7c8@bsb.virtua.com.br> <20030912165047.Z18851@schatzie.adilger.int> <20030912230601.GU4306@holomorphy.com>
Subject: Re: stack overflow
Date: Fri, 12 Sep 2003 20:23:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-XTmail: http://www.verdesmares.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wli,

Exactly that stack users are demand paged , you can calculate the size of
stack. This is will impossible or more difficult to do if you have more that
one mm->start_stack  :)

att
Breno

----- Original Message -----
From: "William Lee Irwin III" <wli@holomorphy.com>
To: "Breno" <brenosp@brasilsec.com.br>; "Kernel List"
<linux-kernel@vger.kernel.org>
Sent: Saturday, September 13, 2003 12:06 AM
Subject: Re: stack overflow


> On Fri, Sep 12, 2003 at 04:50:47PM -0600, Andreas Dilger wrote:
> > Well, with the exception of the fact that STACK_LIMIT is 8MB, and kernel
> > stacks are only 8kB (on i386)...
> > Also, see "do_IRQ()" (i386) for CONFIG_DEBUG_STACKOVERFLOW to see this
already.
>
> What he actually wants is in-kernel user stack overflow checking, which
> is basically impossible since user stacks are demand paged. He's been
> told this before and failed to absorb it.
>
> There have been attempts to use i386 segmentation for stack limit
> checks written but they should probably not be confused with this.
>
>
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

