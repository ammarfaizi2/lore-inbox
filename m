Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265089AbUEUXFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbUEUXFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUEUXC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:02:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:8576 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264488AbUEUW6J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:58:09 -0400
Date: Fri, 21 May 2004 18:58:00 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Stephen Cameron <smcameron@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 and ioctls from 32 bit userland
In-Reply-To: <20040521194224.63535.qmail@web12303.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0405211854590.1296@chaos>
References: <20040521194224.63535.qmail@web12303.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2004, Stephen Cameron wrote:

> Hi, a question about x86_64 and ioctls coming in from 32-bit
> userland.
>
> I found this document describing 32-bit ioctls on 64 bit archs,
> http://shorterlink.com/?47B2OV
> but, it is from July of 2002, so I'm not sure it's up to date.
> Should I look somewhere else?
>
> Also, if my userland process passes in an ioctl data structure
> and that data structure in turn contains ontains a 32 bit pointer
> to another data buffer within that process' address space
> the kernel needs to copy in/oot, how can that be handled?
> Can it be handled?
>
> Thanks,
>
> -- steve

Yes. The user-mode 32-bit pointer within a structure is no different
than passing a 32-bit user-mode pointer as the third parameter to
an ioctl(fd, WHAT, ptr).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


