Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268453AbUJJTmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268453AbUJJTmH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 15:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268457AbUJJTmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 15:42:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17659 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S268453AbUJJTmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 15:42:04 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       linux-kernel@vger.kernel.org,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       "Amakarov@Ru. Mvista. " Com <amakarov@ru.mvista.com>,
       "Eugeny S. Mints" <emints@ru.mvista.com>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       New Zhang Haitao <hzhang@ch.mvista.com>,
       "Yyang@Ch. Mvista. Com" <yyang@ch.mvista.com>
In-Reply-To: <20041010084633.GA13391@elte.hu>
References: <41677E4D.1030403@mvista.com>  <20041010084633.GA13391@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1097437314.17309.136.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 10 Oct 2004 12:41:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-10 at 01:46, Ingo Molnar wrote:
>  - the generic irq subsystem: irq threading is a simple ~200-lines,
>    architecture-independent add-on to this. It makes no sense to offer 3
>    different implementations - pick one and help make it work well.
> 
>  - preemptible BKL. Related to this is new debugging infrastructure in
>    -mm that allows the safe and slow conversion of spinlocks to mutexes. 
>    In the case of the BKL this conversion is expected to be permanent, 
>    for most of the other spinlocks it will be optional - but the 
>    debugging code can still be used.

	Are you referring to the lock metering? I've ported our changes to
-mm3-VP-T3 on top of lock metering. It needs some clean up but It will
be released soon. It's very similar to our rc3 release only without the
IRQ threads patch.

Daniel Walker

