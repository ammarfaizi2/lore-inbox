Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUDSVmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUDSVmv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUDSVmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:42:51 -0400
Received: from mail.ccur.com ([208.248.32.212]:38924 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S261918AbUDSVms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:42:48 -0400
Date: Mon, 19 Apr 2004 17:42:47 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Willy Tarreau <w@w.ods.org>
Cc: cramerj@intel.com, scott.feldman@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] e1000 fails on 2.4.26+bk with CONFIG_SMP=y
Message-ID: <20040419214247.GA5273@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040416224422.GA19095@tsunami.ccur.com> <20040417072455.GD596@alpha.home.local> <20040419165425.GA3988@tsunami.ccur.com> <20040419193930.GA28340@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040419193930.GA28340@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 09:39:30PM +0200, Willy Tarreau wrote:
> On Mon, Apr 19, 2004 at 12:54:25PM -0400, Joe Korty wrote:
>> 
>> Uniprocessor 2.4.26 works fine.
>> Uniprocessor 2.4.26 + local apic works fine.
>> Uniprocessor 2.4.26 + local apic + io apic fails.
> 
> interesting. Unfortunately, I didn't have time to try on the machine I told
> you about last day. But right here, I have a dual athlon communicating
> with an alpha, both with e1000 (544) in 2.4.26. Since there's a PCI
> bridge on your quad, I wonder if the IOAPIC doesn't trigger an interrupt
> routing problem with bridges. Are all the ports unusable or do some of
> them work reliably in APIC mode ?

I just verified that the Quad Ethernet board works with 2.6.5 SMP, so it
is unlikely to be a bridge or other hardware problem.

For 2.4.26, the Dell 650 has an Intel 82545EM Gigabit Ethernet Controller
soldered in, which also uses the e1000 driver, and that works fine, so
we know the 2.4.26 e1000 driver works with some of these Intel chips.

When the Quad board works, it negotiates down to 10 MBits/sec Half Duplex.
Not sure yet if this is what it is supposed to be doing in our environment.

Regards,
Joe

PS: do you CC'ed Intel guys have some insights or data for us?
