Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVBKVxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVBKVxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262359AbVBKVwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:52:40 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:57841 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262357AbVBKVwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:52:35 -0500
Subject: Re: Interrupt starvation points
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050211200424.B28971@flint.arm.linux.org.uk>
References: <1108141521.21940.44.camel@dhcp153.mvista.com>
	 <20050211200424.B28971@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1108158738.21940.126.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Feb 2005 13:52:19 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 12:04, Russell King wrote:
> 
> Please substantiate your claim that up() is very expensive on ARM.
> I disagree:

	I should have made it clear that I was talking about the RT version of
up() . The RT version doesn't have any assembly in it, and it is
expensive. 

> Plus, after you've read the above code, wouldn't you think that adding
> the "enable interrupts + disable interrupts" around an up() operation
> (which itself immediately disables interrupts again) is just adding
> extra instructions to the kernel, which corresponds directly to lower
> performance?

	Not in the RT case. However, I never said that was a proper fix, I was
just producing code that helped in my tests.

Daniel

