Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314275AbSEHNyM>; Wed, 8 May 2002 09:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314292AbSEHNyL>; Wed, 8 May 2002 09:54:11 -0400
Received: from [198.144.45.122] ([198.144.45.122]:1920 "EHLO
	xyzzy.stargate.net") by vger.kernel.org with ESMTP
	id <S314275AbSEHNyK>; Wed, 8 May 2002 09:54:10 -0400
Subject: Re: Memory Barrier Definitions
From: Justin Carlson <justinca@ri.cmu.edu>
To: Dave Engebretsen <engebret@vnet.ibm.com>
Cc: justincarlson@cmu.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CD89247.8ECB01A4@vnet.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 08 May 2002 09:54:24 -0400
Message-Id: <1020866064.1667.3.camel@xyzzy.stargate.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-07 at 22:49, Dave Engebretsen wrote:

> PPC also guarantees every ordering when using the 'sync' instruction, so
> that will give correctness at the price of a 1000 cycles or so.  You
> refer to different rules for cached vs uncached on other implementations
> -- that is the essence of our problem.  Are there different barrier
> instructions in MIPS which provide different levels of performance for
> different ordering enforcements?
> 
> Dave.

No, there aren't.  The implementation details can affect which
primitives need to explicitly sync, though.  

For instance, the BRCM1250 makes some guarantees about visibility of
uncached writes that aren't strictly required by the architecture spec. 

-Justin

