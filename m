Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWJ1VDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWJ1VDS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 17:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWJ1VDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 17:03:18 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:21680 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S964841AbWJ1VDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 17:03:18 -0400
X-Originating-Ip: 72.57.81.197
Date: Sat, 28 Oct 2006 17:01:31 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Luca Tettamanti <kronos.it@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: why "probe_kernel_address()", not "probe_user_address()"?
In-Reply-To: <20061028203014.GA7183@dreamland.darkstar.lan>
Message-ID: <Pine.LNX.4.64.0610281659250.4741@localhost.localdomain>
References: <20061028203014.GA7183@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006, Luca Tettamanti wrote:

> I agree that it may be confusing. The whole point in using
> __get_user() is that it ensures that the source address is valid.
>
> When handle_BUG() is called the kernel is no more in a "sane" state,
> blindly using the content of the registers may lead to a page fault
> in kernel mode. So the code extract filename and line of the BUG
> checking that the line number is indeed readable, the address of the
> string (file name) is readable and it points to a readable memory
> location.
>
> probe_kernel_address wrapper is used to "hide" the fact that we are
> re-using the infrastructure provided by a function with a confusing
> name ;) The cast to __user is needed to keep sparse quiet.

... more response snipped ...

ok, i'm going to defer to people who are clearly much smarter about
this than me, and i'll go back and read that entire response more
carefully until i understand it.  thanks for explaining it.

rday
