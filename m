Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292468AbSBUPqy>; Thu, 21 Feb 2002 10:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292467AbSBUPqo>; Thu, 21 Feb 2002 10:46:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11653 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292465AbSBUPqj>; Thu, 21 Feb 2002 10:46:39 -0500
Date: Thu, 21 Feb 2002 10:48:44 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Joe Wong <joewong@tkodog.no-ip.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: detect memory leak tools?
In-Reply-To: <Pine.LNX.4.33.0202211531440.5429-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1020221104124.20988A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Joe Wong wrote:

> Hi,
> 
>   Is there any tools that can detect memory leak in kernel loadable 
> module?
> 
> TIA.
> 
> - Joe

How would it know? If you can answer that question, you have made
the tool. It would be specific to your module. FYI, in designing
such a tool, you often the find the leak, which means you don't
need the tool anymore.

I would start by temporarily putting a wrapper around whatever you
use for memory allocation and deallocation. The wrapper code keeps
track of pointer values and outstanding allocations. If the outstanding
allocations grow or if the pointers to whatever_free() are different
than the pointers to whatever_alloc(), you have a leak. You can read
the results from a private ioctl().

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

