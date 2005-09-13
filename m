Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVIMDBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVIMDBA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 23:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbVIMDBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 23:01:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21216 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932342AbVIMDA7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 23:00:59 -0400
Date: Mon, 12 Sep 2005 20:00:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
In-Reply-To: <1126569577.25875.25.camel@defiant>
Message-ID: <Pine.LNX.4.58.0509121950340.3266@g5.osdl.org>
References: <1126569577.25875.25.camel@defiant>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 12 Sep 2005, Norbert Kiesel wrote:
> 
> I append the lspci -vvv from both 2.6.12.5 and 2.6.13.1  The diff
> between these two is:

Can you do "lspci -vvx" instead (the numbers are actually meaningful:  
they say what the hardware has been told, while the symbolic info contains
some stuff that lspci actually gathered through other means by querying
the kernel).

Also, "diff -U 50 working broken" is a really nice way to show not only
the differences - it gives enough context that you can see all the
relevant info from the diff, and you don't even need to show the two
different versions separately (ie the diff itself ends up containing
pretty much all relevant info).

Finally - if you can try to pinpoint it somewhat more (eg "2.6.13-rc3 is
ok, -rc4 is not"), that would be very helpful..

		Linus
