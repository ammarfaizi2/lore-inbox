Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270774AbRHSU4m>; Sun, 19 Aug 2001 16:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270775AbRHSU4c>; Sun, 19 Aug 2001 16:56:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54825 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S270774AbRHSU4Z>; Sun, 19 Aug 2001 16:56:25 -0400
To: esr@thyrsus.com
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, gars@lanm-pc.com
Subject: Re: Swap size for a machine with 2GB of memory
In-Reply-To: <20010819024233.A26916@thyrsus.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Aug 2001 14:49:23 -0600
In-Reply-To: <20010819024233.A26916@thyrsus.com>
Message-ID: <m11ym7ojvw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" <esr@thyrsus.com> writes:

> The Red Hat installation manual claims that the size of the swap partition
> should be twice the size of physical memory, but no more than 128MB.
> 
> The screaming hotrod machine Gary Sandine and I built around the Tyan S2464
> has 2GB of physical memory.  Should I believe the above formula?  If not,
> is there a more correct one for calculating needed swap on machines with
> very large memory?

There is no magic formula for calculating the amount of swap space
needed.  It really needs to be sized to the expected load on your box
plus some.  If you seriously expect to be using swap,  have swapsize >
memsize and figure the amount of virtual memory you have is swapsize.

With respect to swap partitions the current limit is about 64Gig.
You can actually make a larger swap partition but the kernel on x86
only uses 24 offset bits into that partition.  The 128MB partition
existed but was removed long ago.

Eric
