Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUBCXiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 18:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUBCXiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 18:38:22 -0500
Received: from gotroot.insekure.com ([207.254.222.218]:64264 "EHLO
	speedy.insekure.com") by vger.kernel.org with ESMTP id S266181AbUBCXiM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 18:38:12 -0500
Date: Tue, 3 Feb 2004 17:45:25 -0600 (CST)
From: James Schmidt <james@JamesSchmidt.Com>
X-X-Sender: james@speedy.insekure.com
To: linux-kernel@vger.kernel.org
Subject: Re: broken maxcpus in 2.4.24
In-Reply-To: <1075765034.17943.79.camel@reactor.us.proofpoint.com>
Message-ID: <20040203150930.W17910@speedy.insekure.com>
References: <1075765034.17943.79.camel@reactor.us.proofpoint.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hope this hasn't been posted already.

Not sure if I am right or not on this but this seems to be related, at
least on my box, to the APIC IDs of the CPUs.  I am using an Intel
SE7500CW, populated with 2x XEONs.  The APIC ID's of the CPUs are 0 & 1
for the first physical CPU, and 6 & 7 for the second physical CPU (don't
ask me why).  If I don't use NR_CPUs = 8, I don't seem to see the second
physical CPU.  Someone correct me if I'm wrong.

-James

On Mon, 2 Feb 2004, Dan Christian wrote:

> I compiled a vanilla 2.4.24 for a 2 processor Xeon.
>
> I set CONFIG_NR_CPUS to 4 (2 CPUs x 2 hyperthreads each).
>
> When I boot the kernel, /proc/cpuinfo only shows 2 cpus (0-1) and
> performance is bad.
>
> I reconfigure CONFIG_NR_CPUS back to 32.  Now it shows 4 cpus (0-3) and
> performance is normal.
>
> Is this a bug or am misunderstanding how to set this configuration
> variable?
>
> -Dan Christian
>
