Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263998AbTDJHzE (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 03:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbTDJHzE (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 03:55:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:9126 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263998AbTDJHzD (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 03:55:03 -0400
Date: Thu, 10 Apr 2003 04:06:43 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Matt Domsch <Matt_Domsch@dell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: balance_irq()'s move() while in machine_restart() hangs system
In-Reply-To: <1049928786.5244.108.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304100406001.13150-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Apr 2003, Matt Domsch wrote:

> Is it fair to change smp_send_stop() to call
> smp_call_function(stop_this_cpu, NULL, 1, 1) instead (make it wait for
> the other CPUs to complete before continuing)?

sure, it's fair - at that point all the notification has been done.

	Ingo

