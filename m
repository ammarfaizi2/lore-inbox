Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbUKFVee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbUKFVee (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 16:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUKFVed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 16:34:33 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:30660 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S261478AbUKFVec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 16:34:32 -0500
Date: Sat, 6 Nov 2004 16:32:09 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Andi Kleen <ak@suse.de>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: breakage: flex mmap patch for x86-64
In-Reply-To: <20041106125049.GB16434@wotan.suse.de>
Message-ID: <Pine.GSO.4.33.0411061613110.9358-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Nov 2004, Andi Kleen wrote:
>On Sat, Nov 06, 2004 at 10:50:27AM +0100, Rafael J. Wysocki wrote:
>> On Saturday 06 of November 2004 10:12, Andi Kleen wrote:
>> > >  static inline int mmap_is_legacy(void)
>> > >  {
>> > > +       if (test_thread_flag(TIF_IA32))
>> > > +               return 1;
>> >
>> > That's definitely not the right fix because for 32bit you need flexmmap
>> > more than for 64bit because it gives you more address space.
>>
>> So let's call it temporary, but I like 32-bit apps having less address space
>> rather than segfaulting.
>
>If you want a temporary fix use the appended one.  But I think Linus pulled it anyways.

Right, wrong, whatever.  Using the legacy mmap for IA32 works.  And it works
exactly as before flexmmap was added.  Setting "vm.legacy_va_layout" will
work, but disables flexmmap across the board.

What is it with flexmmap that's causing 32bit apps to fail?

--Ricky


