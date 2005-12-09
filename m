Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbVLIT6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVLIT6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVLIT63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:58:29 -0500
Received: from fattire.cabal.ca ([134.117.69.58]:31725 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S932427AbVLIT63 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:58:29 -0500
Date: Fri, 9 Dec 2005 14:58:16 -0500
From: Kyle McMartin <kyle@mcmartin.ca>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
Message-ID: <20051209195816.GF32168@quicksilver.road.mcmartin.ca>
References: <1134154208.14363.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134154208.14363.8.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 01:50:08PM -0500, Lee Revell wrote:
> I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
> I added -m64 to the CFLAGS as per the gcc docs.  But the build fails
> with:
> 
> $ make ARCH=x86_64
> arch/x86_64/kernel/entry.S:785: Error: cannot represent relocation type BFD_RELOC_64

Ubuntu/Debian provide a biarch gcc, but do not (did not?) provide a biarch
assembler. Building binutils for target x86_64-pc-linux-gnu should help.
