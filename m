Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268191AbUH2RC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268191AbUH2RC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 13:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268204AbUH2RBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 13:01:45 -0400
Received: from holomorphy.com ([207.189.100.168]:34222 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268191AbUH2RAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 13:00:44 -0400
Date: Sun, 29 Aug 2004 10:00:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roland Dreier <roland@topspin.com>, jmerkey@comcast.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jmerkey@drdos.com
Subject: Re: 1GB/2GB/3GB User Space Splitting Patch 2.6.8.1 (PSEUDO SPAM)
Message-ID: <20040829170037.GJ5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Roland Dreier <roland@topspin.com>, jmerkey@comcast.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jmerkey@drdos.com
References: <082620040421.9849.412D655C000690BA000026792200735446970A059D0A0306@comcast.net> <20040826043318.GO2793@holomorphy.com> <52isb6bj64.fsf@topspin.com> <20040826044954.GP2793@holomorphy.com> <1093783694.27899.7.camel@localhost.localdomain> <20040829164239.GH5492@holomorphy.com> <1093794337.28141.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093794337.28141.8.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-29 at 17:42, William Lee Irwin III wrote:
>> The big nasty is that userspace has very little to go on here. We need
>> to report the limits of the address space somewhere for this kind of
>> affair and probably even hammer out our own addenda to ABI specs so
>> instead of SVR4 $ARCH/ELF ABI spec we have a Linux $ARCH/ELF ABI spec.
>> I see no one so motivated to make backward-incompatible ABI changes
>> that they are willing to do that kind of work.

On Sun, Aug 29, 2004 at 04:45:37PM +0100, Alan Cox wrote:
> Ok so I can compile with a.out support. End of problem, that makes the
> patch useful and "spec compliant", although the spec compliance is
> irrelevant anyway. The spec doesn't determine what Linux is it's a
> useful reference for normality. Special cases are special cases and you
> harm the system by seeking to stop stuff that works purely for pieces of
> paper.

Not quite. For one, it does actually break some apps. You can do it,
you just have to have some idea of what you're breaking and propagate
that onward somehow. Backward-incompatible userspace ABI changes can't
be undertaken as lightly as backward-incompatible kernel ABI changes.
There needs to be something that says "backward-incompatible ABI change
happened $HERE" somewhere people who aren't kernel hacking can find it.
There has to be some kind of warning somewhere; we can't just do it silently.


-- wli
