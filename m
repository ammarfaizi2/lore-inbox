Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264835AbUE0Prr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264835AbUE0Prr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbUE0Prr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:47:47 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:38298 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264835AbUE0Prp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:47:45 -0400
Date: Thu, 27 May 2004 17:46:30 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527154630.GA31077@wohnheim.fh-wedel.de>
References: <20040527145935.GE23194@wohnheim.fh-wedel.de> <4382.1085670482@ocs3.ocs.com.au> <20040527152156.GI23194@wohnheim.fh-wedel.de> <1085672066.7179.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1085672066.7179.3.camel@laptop.fenrus.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2004 17:34:26 +0200, Arjan van de Ven wrote:
> 
> you can write "add 100,%esp" as "sub -100, %esp" :)
> compilers seem to do that at times, probably some cpu model inside the
> compiler decides the later is better code in some cases  :)

Makes sense (in a way).  For x86 and ppc*, my script should be safe as
a nice side effect:
qr/^.*sub    \$(0x$x{3,5}),\%esp$/o

Anything above 5 digits is ignored.  That also misses allocations
above 1MB, but as long as human stupidity is finite... ;)

Jörn

-- 
ticks = jiffies;
while (ticks == jiffies);
ticks = jiffies;
-- /usr/src/linux/init/main.c
