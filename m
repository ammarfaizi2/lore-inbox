Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130704AbRBTUSl>; Tue, 20 Feb 2001 15:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130708AbRBTUSb>; Tue, 20 Feb 2001 15:18:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7296 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S130704AbRBTUSP>; Tue, 20 Feb 2001 15:18:15 -0500
Date: Tue, 20 Feb 2001 15:17:39 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: hiren_mehta@agilent.com
cc: linux-kernel@vger.kernel.org
Subject: Re: can somebody explain barrier() macro ?
In-Reply-To: <FEEBE78C8360D411ACFD00D0B74779718809AB@xsj02.sjs.agilent.com>
Message-ID: <Pine.LNX.3.95.1010220151314.1154A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Feb 2001 hiren_mehta@agilent.com wrote:

> Hi,
> 
> barrier() is defined in kernel.h as follows :
> 
> #define barrier() __asm__ __volatile__("": : :"memory")
> 
> 
> what does this mean ? is this like "nop" ?
> 

It tells the compiler that memory was, or is about to be, modified.
Therefore, the complier must put back into memory anything it
was caching, and after the barrier, it must re-read anything it
uses from memory. It, itself, generates no code, but the compiler
will usually spew out some 'extra' instructions as a result of
this, so it isn't a "nop".


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


