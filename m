Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266847AbRGFVCu>; Fri, 6 Jul 2001 17:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266848AbRGFVCk>; Fri, 6 Jul 2001 17:02:40 -0400
Received: from [64.64.109.142] ([64.64.109.142]:51983 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S266847AbRGFVC2>; Fri, 6 Jul 2001 17:02:28 -0400
Message-ID: <3B46275E.C84E0E38@didntduck.org>
Date: Fri, 06 Jul 2001 17:02:22 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: anderson@centtech.com
CC: linux-kernel@vger.kernel.org
Subject: Re: BIGMEM kernel question
In-Reply-To: <3B4624C9.18290280@centtech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Anderson wrote:
> 
> I am currently running a RedHat 7.1 machine with the 2.4.3-12enterprise
> kernel.  My machine has 4GB of RAM, and 6GB of swap.  It appears that I
> can only allocate 2930 MB (using heapc_linux and other programs).  What
> do I need to do to get Linux to allow allocation of all available memory
> (up to the 4GB)?  All the FAQs I have seen so far explain only how to
> get Linux to recognize the 4GB, and not use it all in one process.  Any
> help would be greatly appreciated.

On a 32-bit architecture, Linux gives each user process 3GB of virtual
address space.  Into that 3GB address space you need to map your stack,
exectuable images, shared libaries, etc. with the rest left for the
heap.  If you need more memory in a single process you're better off
moving to a 64-bit architecture.  Note that multiple processes, as well
as the various caches can use the remaining memory.

--

				Brian Gerst
