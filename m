Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTLKPA0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 10:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTLKPA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 10:00:26 -0500
Received: from holomorphy.com ([199.26.172.102]:55781 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265069AbTLKPAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 10:00:17 -0500
Date: Thu, 11 Dec 2003 07:00:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Raul Miller <moth@magenta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <20031211150011.GF8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Raul Miller <moth@magenta.com>, linux-kernel@vger.kernel.org
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org> <3FD7FCF5.7030109@cyberone.com.au> <3FD801B3.7080604@wmich.edu> <20031211054111.GX8039@holomorphy.com> <20031211094148.G28449@links.magenta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031211094148.G28449@links.magenta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 09:41:11PM -0800, William Lee Irwin III wrote:
>> You're probably thinking of 2:2 split patches.
>> 2:2 splits are at least technically ABI violations, which is probably
>> why this isn't merged etc. Applications sensitive to it are uncommon.
>> Yes, the SVR4 i386 ELF/ABI spec literally mandates 0xC0000000 as the
>> top of the process address space.

On Thu, Dec 11, 2003 at 09:41:48AM -0500, Raul Miller wrote:
> Apologies if I'm asking about the obvious, but... 
> [1] isn't 0xC0000000 at 3GB?  

It is.


On Thu, Dec 11, 2003 at 09:41:48AM -0500, Raul Miller wrote:
> [2] Even if ELF did restrict a user process to 1GB (which I'm pretty
> sure it doesn't), wouldn't the kernel still be able to manage 2GB of
> user memory?

You have it backward. The SVR4/i386 ELF ABI specification is requiring
userspace to be granted at least 3GB of address space.

This does not necessarily present a restriction for the kernel;
consider task gates (mingo did it by hand).


On Thu, Dec 11, 2003 at 09:41:48AM -0500, Raul Miller wrote:
> Probably my real question is: "what's this about 2:2 split patches"?
> Basically, I thought "linux supports 2GB ram" had been been the case
> since the dark ages.  It's hard for me to comprehend how highmem, or 64
> bit cpus, could have much to do with a 1GB limit.

You should probably ignore this thread. It's probably not relevant to
you.


On Thu, Dec 11, 2003 at 09:41:48AM -0500, Raul Miller wrote:
> [In my fantasies, I was thinking that the system came up with only 1GB of
> the memory easily usable, and that the lack of support for my hardware
> meant that it couldn't be properly reconfigured.  But I recognize that
> I haven't spent the time researching this to see if in fact this is
> the case.]

Highmem support gets you this on ia32. Other architectures can support it
with less overhead.


On Thu, Dec 11, 2003 at 09:41:48AM -0500, Raul Miller wrote:
> I am in the process of bringing up an cross compilation environment for
> amd64 -- I need to do that anyways -- and I'll try building a real 64
> bit kernel to see if that helps any.  If that doesn't, I guess I'll try
> a couple 4G highmem kernels (one 64 bit, one 32 bit).  If nothing else,
> that will eat up some time...

If you have such a cpu why are you bothering with highmem (or wondering
if > 2GB is supported)?


-- wli
