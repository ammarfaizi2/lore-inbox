Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268465AbTANBH2>; Mon, 13 Jan 2003 20:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268467AbTANBH1>; Mon, 13 Jan 2003 20:07:27 -0500
Received: from chaos.analogic.com ([204.178.40.224]:54917 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268465AbTANBHZ>; Mon, 13 Jan 2003 20:07:25 -0500
Date: Mon, 13 Jan 2003 20:20:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Ross Biro <rossb@google.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
In-Reply-To: <1042495640.587.30.camel@zion.wanadoo.fr>
Message-ID: <Pine.LNX.3.95.1030113201527.31662A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jan 2003, Benjamin Herrenschmidt wrote:

> On Mon, 2003-01-13 at 22:40, Richard B. Johnson wrote:
> 
> > There is a well-defined procedure for this. Any "read" anywhere
> > in the PCI address space, will force all posted writes to complete.
> > However, the "read" will not be the data one would obtain after
> > the write completes. 
> 
> Just to avoid confusion, the above is obviously wrong, the read will
> indeed force pending store queues to complete _in order_, the read will
> reach the device after the stores are complete and you'll read the value
> you would get after the write normally. At least on PCI ;)
> 
> Ben.
> 

It is not, as you say; "obviously wrong". It is, in fact correct.
If you think you will get, as previously stated, the current status
by reading the status register of a device, while a posted-write
is in-progress, the code is broken. There are warnings all over
PCI device hardware specifications about this. 


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


