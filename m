Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932669AbVJCUA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbVJCUA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 16:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932681AbVJCUA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 16:00:57 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:21550 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932669AbVJCUA5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 16:00:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nfKzeqajpveuxjcq4s9latgmm8jiHITpHnGFdOdZJHFQjtqUAtGvJMZ5uzXLdC35PCAS8cSnJX4HHNHvXTSM0vxTrBfDCZfr18fq7IWYW6RTUNVAKLn7ZgG5Oqi5Z9RzvdbUOrCdN9DH6wBcv+CikKQp8qXeWYjyDMCafjSEArc=
Message-ID: <35fb2e590510031300h3c991795l807b5de265c9d9d6@mail.gmail.com>
Date: Mon, 3 Oct 2005 21:00:55 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: what's next for the linux kernel?
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Meelis Roos <mroos@linux.ee>, lkcl@lkcl.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0510031416560.24845@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051003004442.GL6290@lkcl.net>
	 <20051003075000.28A8C13ED9@rhn.tartu-labor>
	 <20051003180858.GA8011@csclub.uwaterloo.ca>
	 <Pine.LNX.4.61.0510031416560.24845@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, linux-os (Dick Johnson) <linux-os@analogic.com> wrote:
>
> On Mon, 3 Oct 2005, Lennart Sorensen wrote:

> > I suspect most 'simple' OS teaching tools are awful.  Of course writing
> > a complete OS from scratch is a serious pain and makes debuging much
> > harder than if you can do your work on top of a working OS that can
> > print debug messages.

> But the first thing you must do in a 'roll-your-own' OS is to make
> provisions to write text to (sometimes a temporary) output device
> and get some input from same.

Indeed. I started work on a microkernel for a final year University
project. Didn't get very far beyond minimal memory management and a
vague handy-wavy concept of a process in the end as it's easy to get
unstuck figuring out random blackbox hardware. Makes you respect some
of these people who really figured it out for real and got it working.

> Writing such basic stuff is getting harder because many embedded
> systems don't have UARTS, screen-cards, keyboards, or any useful
> method of doing I/O.

It's easier now that we have a growing number of cheaper ARM/PPC
boards on the market. But in order to do much of this, you really need
a hardware debugger. In my case, I tried to do this on an Apple
powerbook but once you've broken the BAT/page mapping for your
framebuffer you're rapidly running out of ways of debugging, e.g. a
VM. It's difficult enough even with a UART, or an LED, or whatever.

> This is where an existing OS (Like Linux) can help you get some I/O
> running, perhaps through a USB bus. You debug and make it work
> as a Linux Driver, then you link the working stuff into your headless
> CPU board.

A lot of people end up doing that - I've heard of some interesting
stories which I'm sure aren't widespread. One case, the guy had
basically bolted a small realtime module on to Linux (not really quite
like RTLinux) but had been able to do a lot of testing through
existing APIs. Another trick is to write as much as you can to sit
right atop the existing firmware - OpenFirmware, U-Boot, whatever and
perhaps even forgo trying to handle exceptions/VM for yourself in the
beginning.

Jon.
