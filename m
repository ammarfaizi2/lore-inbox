Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbUCCTql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 14:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbUCCTqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 14:46:40 -0500
Received: from ns.suse.de ([195.135.220.2]:36042 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262568AbUCCTq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 14:46:27 -0500
Date: Wed, 3 Mar 2004 16:57:18 +0100
From: Andi Kleen <ak@suse.de>
To: Peter Williams <peterw@aurema.com>
Cc: linux-kernel@vger.kernel.org, johnl@aurema.com
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
Message-Id: <20040303165718.379f9151.ak@suse.de>
In-Reply-To: <404554D8.5040800@aurema.com>
References: <fa.fi4j08o.17nchps@ifi.uio.no.suse.lists.linux.kernel>
	<fa.ctat17m.8mqa3c@ifi.uio.no.suse.lists.linux.kernel>
	<yydjishqw10p.fsf@galizur.uio.no.suse.lists.linux.kernel>
	<40426E1C.8010806@aurema.com.suse.lists.linux.kernel>
	<p73k7224pdn.fsf@brahms.suse.de>
	<404554D8.5040800@aurema.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2004 14:45:28 +1100
Peter Williams <peterw@aurema.com> wrote:

> Andi Kleen wrote:
> > Peter Williams <peterw@aurema.com> writes:
> > 
> > One comment on the patches: could you remove the zillions of numerical Kconfig
> > options and just make them sysctls? I don't think it makes any sense 
> > to require a reboot to change any of that. And the user is unlikely
> > to have much idea yet on what he wants on them while configuring.
> 
> The default initial values should be fine and the default configuration 
> allows the scheduling tuning parameters (i.e. half life and time slice 
>        ) to be changed on a running system via the /proc file system. 

I'm running the 2.6.3-full patch on my workstation now. No tuning applied
at all. I reniced the X server to -10. When I have two kernel compiles (without any -j*) 
running there is  a visible (=not really slow, but long enough to notice something) 
delay in responses while typing something in a xterm. In sylpheed there
is the same issue.

The standard scheduler didn't show this that extreme with only two compiles.

-Andi
