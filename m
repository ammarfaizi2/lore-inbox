Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290294AbSAOVmU>; Tue, 15 Jan 2002 16:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290300AbSAOVmK>; Tue, 15 Jan 2002 16:42:10 -0500
Received: from quark.didntduck.org ([216.43.55.190]:65291 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S290294AbSAOVmH>; Tue, 15 Jan 2002 16:42:07 -0500
Message-ID: <3C44A224.120712C1@didntduck.org>
Date: Tue, 15 Jan 2002 16:41:56 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zaitsev <pz@spylog.ru>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3.5G user space speed
In-Reply-To: <16247691406.20020115234737@spylog.ru>
	 <3C4499A3.781E5A85@didntduck.org> <15850171252.20020116002857@spylog.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev wrote:
> 
> Hello Brian,
> 
> Wednesday, January 16, 2002, 12:05:39 AM, you wrote:
> 
> BG> You can't have it both ways with the x86 (speed vs. large userspace).
> BG> Kernel 2.5 may help a bit here because changes were made to allow DMA
> BG> from all memory (subject to card limitations), lessening the burden for
> BG> direct-mapped memory.  Otherwise you'll need to move to a 64-bit arch.
> 
> Well. May be you can tell about the numbers a bit ? I can chose 3.0G
> for user instead of 3.5G for user with not really huge loss, but I'd
> like to know how much it will increase speed and in which cases, also
> about standard 2/2 mode.

I don't have quantifiable numbers available, but the speed issue will be
a result of the kernel running out of direct-mapped memory and having to
start swapping even though there is free memory in the system (in the
highmem zone).  The best thing you can do is try both and find what
works best for you.

--

				Brian Gerst
