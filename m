Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276665AbRKAAco>; Wed, 31 Oct 2001 19:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276675AbRKAAcf>; Wed, 31 Oct 2001 19:32:35 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:32576 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S276665AbRKAAcX>; Wed, 31 Oct 2001 19:32:23 -0500
Date: Thu, 1 Nov 2001 11:42:13 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20-pre12
In-Reply-To: <20011031144156.A15003@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.05.10111011106220.29197-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Alan Cox wrote:

> Final pieces. This tree will become 2.2.20 at the weekend unless something
> absolutely critical comes up
[snip]

"VIA686a test code..." in arch/i386/kernel/time.c (introduced in
2.2.19pre1?) produces surprising results[1] on my AcerNote-950 (which
doesn't have a VIA686 (it's a Pentium) and FWIW does have BIOS horked in
at least the APM department).  Searching The Fine Web for "probable
hardware bug: clock timer configuration lost" suggests that this "fix"
may be causing "surprises" on other non-VIA686a machines too[2].

Attached (COMPLETELY UNTESTED) patch attempts to implement a kernel
command-line switch "via686_hacks=none" to disable this "feature".  The
framework for this patch was lifted from arch/i386/kernel/apm.c .

Am I barking up the right tree here?

Is it worth my while trying to beat this one up in the next 24hours (if
not I'll put it in the fridge till I'm on Jury Duty next week :-( ).

Thanks,
Neale.

[1] http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.3/0204.html
[2] http://www.google.com/linux?site=search&restrict=linux&hl=en&q=%22probable+hardware+bug%3A+clock+timer+configuration+lost%22&btnG=Google+Search

