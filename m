Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267847AbRGUXc5>; Sat, 21 Jul 2001 19:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267848AbRGUXcr>; Sat, 21 Jul 2001 19:32:47 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:12804 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267847AbRGUXck>; Sat, 21 Jul 2001 19:32:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "peter k." <spam-goes-to-dev-null@gmx.net>
Subject: Re: 2.4.7: wtf is "ksoftirqd_CPU0"
Date: Sun, 22 Jul 2001 01:37:02 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000f01c111ff$73602ce0$c20e9c3e@host1> <3B59AFF7.8061645B@mandrakesoft.com>
In-Reply-To: <3B59AFF7.8061645B@mandrakesoft.com>
MIME-Version: 1.0
Message-Id: <01072201370202.02679@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Saturday 21 July 2001 18:38, Jeff Garzik wrote:
> "peter k." wrote:
> > i just installed 2.4.7, now a new process called "ksoftirqd_CPU0"
> > is started automatically when booting (by the kernel obviously)?
> > why? what does it do? i didnt find any useful information on it in
> > linuxdoc / linux-kernel archives
>
> it is used internally, ignore it.

It's pretty hard to ignore a process with a name that ugly ;-)

How about just ksoft0 ?  Or kirq0?

I don't see the sense of trying to encode a whole sentence into the 
process name.

(Peter, this handles softirqs in a more predictable way by allowing the 
scheduler to take care of any softirq that can't conveniently be 
executed immediately.  Among other benefits, this approach eliminated 
the need to check for and execute pending softirqs on exit from system 
calls.)

--
Daniel
