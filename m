Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWHRFaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWHRFaX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 01:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWHRFaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 01:30:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17381 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964794AbWHRFaW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 01:30:22 -0400
Date: Thu, 17 Aug 2006 22:30:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, Greg KH <greg@kroah.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/3] Support piping into commands in
 /proc/sys/kernel/core_pattern
Message-Id: <20060817223009.932f9383.akpm@osdl.org>
In-Reply-To: <1155814064.15195.60.camel@localhost.localdomain>
References: <20060814127.183332000@suse.de>
	<20060814112732.684D313BD9@wotan.suse.de>
	<20060816084354.GF24139@kroah.com>
	<20060816111801.0fc5093e.ak@muc.de>
	<20060816111025.1ab702a1.akpm@osdl.org>
	<20060817094640.GA3173@muc.de>
	<1155814064.15195.60.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006 12:27:44 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Iau, 2006-08-17 am 11:46 +0200, ysgrifennodd Andi Kleen:
> > Several people from the embedded area wrote me privately
> > it would be useful for them. Also I think once it's in the main kernel
> > there will be more incentive for user space to use it and I'm optimistic
> > it will get some adoption (ok I guess I should write some better
> > documentation, but there was no obvious place for it)
> 
> I don't believe that piping as such as neccessarily the right model, but
> the ability to intercept and processes core dumps from user space is
> asked for by many enterprise users as well. They want to know about,
> capture, analyse and process core dumps, often centrally and in
> automated form.
> 

OK, fair enough.

Now let's think about security.  Patches against ptrace, coredump and
procfs give me the creeps because we've had (relatively) so many problems
in those areas in the past.

So I'd suggest that we should look at this code and think about it in a
really twisted fashion - does it open any exploits?  I can't think of any,
which is worth practically zero, but I don't see how this differs from
/proc/sys/kernel/modprobe.

But still.   Is this code secure?
