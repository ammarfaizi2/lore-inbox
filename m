Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbRE1Wo2>; Mon, 28 May 2001 18:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbRE1WoS>; Mon, 28 May 2001 18:44:18 -0400
Received: from rbfux.rbfnet.com ([167.132.252.228]:268 "EHLO rbfux.rbfnet.com")
	by vger.kernel.org with ESMTP id <S261309AbRE1WoN>;
	Mon, 28 May 2001 18:44:13 -0400
Message-Id: <200105282244.RAA19619@rbfux.rbfnet.com>
Subject: Re: Potenitial security hole in the kernel
To: vlebedev@aplio.fr (Vadim Lebedev)
Date: Mon, 28 May 2001 17:44:08 -0500 (CDT)
From: "Brett Frankenberger" <rbf@rbfnet.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP> from "Vadim Lebedev" at May 28, 2001 11:43:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi folks,
> 
> Please correct me if i'm wrong but it seems to me that i've stumbled on
> really BIG security hole in the signal handling code.
> The problem IMO is that the signal handling code stores a processor context
> on the user-mode stack frame which is active while
> the signal handler is running. Then sys_sigreturn restores back the context
> from user mode stack...
> Suppose the signal handler modifies this context frame for example by
> storing into the PC slot address of the panic routine
> then when handler will exit  panic will be called with obvious results.
> 
> 
> Please CC your comments to me directly as i'm not subscibed to this list
> 
> Vadim Lebedev
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

