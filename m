Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVFLP0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVFLP0o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 11:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVFLP0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 11:26:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34812 "EHLO
	godzilla.mvista.com") by vger.kernel.org with ESMTP id S261842AbVFLP0e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 11:26:34 -0400
Date: Sun, 12 Jun 2005 08:26:27 -0700 (PDT)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Karim Yaghmour <karim@opersys.com>, Kristian Benoit <kbenoit@opersys.com>,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, pmarques@grupopie.com,
       bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au, ak@muc.de,
       sdietrich@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
In-Reply-To: <20050612061108.GA4554@elte.hu>
Message-ID: <Pine.LNX.4.10.10506120824140.7591-100000@godzilla.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Jun 2005, Ingo Molnar wrote:

> ok, this method should work fine. I suspect you increased the parport 
> IRQ's priority to the maximum on the PREEMPT_RT kernel, correct? Was 
> there any userspace thread on the target system (receiving the parport 
> request and sending the reply), or was it all done in a kernelspace 
> parport driver?

Whatever interrupt is used should be SA_NODELAY if you want maximum
response. The interrupt would need to be validated though , not to lock
mutexes. 

Daniel

