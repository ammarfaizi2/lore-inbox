Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbUKOBNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbUKOBNw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 20:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbUKOBNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 20:13:46 -0500
Received: from fsmlabs.com ([168.103.115.128]:19844 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S261424AbUKOBLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 20:11:18 -0500
Date: Sun, 14 Nov 2004 18:10:49 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] lockless MCE i386 port
In-Reply-To: <20041114085147.GD16795@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0411141808030.3754@musoma.fsmlabs.com>
References: <Pine.LNX.4.61.0411090126190.3047@musoma.fsmlabs.com>
 <Pine.LNX.4.61.0411130627050.3062@musoma.fsmlabs.com> <20041114085147.GD16795@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Nov 2004, Andi Kleen wrote:

> Looks good from a first look.
> 
> One issue is that you will need people to run the mcelog cron job
> and create /dev/mcelog, otherwise they won't see any non fatal
> warnings anymore.
> 
> I'm actually considering to add a tasklet/bit on x86-64 to printk
> a one line warning when any events are in the log. Perhaps that
> would be a good idea here too to make the migration smoother.

I've actually left the nonfatal code to printk from it's timer, then i 
have the events which come via int18 to schedule a tasklet which prints 
all the output. So it should all functional similarly to the same code 
without any userspace changes. Do folks want /dev/mcelog?

Thanks,
	Zwane

