Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268502AbUJJVWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268502AbUJJVWW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 17:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268505AbUJJVWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 17:22:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:31203 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268502AbUJJVWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 17:22:20 -0400
Date: Sun, 10 Oct 2004 14:20:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: dwalker@mvista.com
Cc: mingo@elte.hu, sdietrich@mvista.com, linux-kernel@vger.kernel.org,
       abatyrshin@ru.mvista.com, amakarov@ru.mvista.com, emints@ru.mvista.com,
       ext-rt-dev@mvista.com, hzhang@ch.mvista.com, yyang@ch.mvista.com
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-Id: <20041010142000.667ec673.akpm@osdl.org>
In-Reply-To: <1097437314.17309.136.camel@dhcp153.mvista.com>
References: <41677E4D.1030403@mvista.com>
	<20041010084633.GA13391@elte.hu>
	<1097437314.17309.136.camel@dhcp153.mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker <dwalker@mvista.com> wrote:
>
> On Sun, 2004-10-10 at 01:46, Ingo Molnar wrote:
>  >  - the generic irq subsystem: irq threading is a simple ~200-lines,
>  >    architecture-independent add-on to this. It makes no sense to offer 3
>  >    different implementations - pick one and help make it work well.
>  > 
>  >  - preemptible BKL. Related to this is new debugging infrastructure in
>  >    -mm that allows the safe and slow conversion of spinlocks to mutexes. 
>  >    In the case of the BKL this conversion is expected to be permanent, 
>  >    for most of the other spinlocks it will be optional - but the 
>  >    debugging code can still be used.
> 
>  	Are you referring to the lock metering? I've ported our changes to
>  -mm3-VP-T3 on top of lock metering.

Lockmeter gets in the way of all this activity in a big way.   I'll drop it.
