Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281570AbRKMJr2>; Tue, 13 Nov 2001 04:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281569AbRKMJrT>; Tue, 13 Nov 2001 04:47:19 -0500
Received: from mailer.zib.de ([130.73.108.11]:13463 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S281566AbRKMJrP>;
	Tue, 13 Nov 2001 04:47:15 -0500
Date: Tue, 13 Nov 2001 10:47:09 +0100
From: Sebastian Heidl <heidl@zib.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: doing a callback from the kernel to userspace
Message-ID: <20011113104709.C5446@csr-pc1.zib.de>
In-Reply-To: <20011112180505.A5446@csr-pc1.zib.de> <Pine.LNX.3.95.1011112133630.7750A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1011112133630.7750A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Mon, Nov 12, 2001 at 01:39:46PM -0500
X-www.distributed.net: 27 OGR packets (3.56 Tnodes) [4.21 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 01:39:46PM -0500, Richard B. Johnson wrote:
> Please check the 'standard' ways of making drivers before you hack
> together something as Linux-specific as a kernel thread. I have
I think a kernel thread is not a choice for me as I truly want to execute
userspace code. As I said before: like a signal handler.

> drivers that are interrupted 10,000 times per second, transfer
> data from hardware buffers in 20,240 byte chunks at an overall
> transfer rate of 24 megabytes per second. The task(s) waiting
> for these data sleep in poll(), then call read() when data
> starts to arrive. This is the De-facto standard way for Unix
> systems. I don't have "latency" problems.
Well I'm talking about really fast networking so every _micro_second I save is
worth it. My numbers are a bit different: Think about a Gigabit-Ethernet card
sending you about 80000 interrupts if it's in a bad mood ;-)

To give you a figure: I'm trying to get below 10 us for user to user latency.
Have a look at the benchmarks at www.myri.com.

thanks anyway ;-)
_sh_


