Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281566AbRKMJri>; Tue, 13 Nov 2001 04:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281569AbRKMJr2>; Tue, 13 Nov 2001 04:47:28 -0500
Received: from mailer.zib.de ([130.73.108.11]:15511 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S281566AbRKMJrY>;
	Tue, 13 Nov 2001 04:47:24 -0500
Date: Tue, 13 Nov 2001 10:47:20 +0100
From: Sebastian Heidl <heidl@zib.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: doing a callback from the kernel to userspace
Message-ID: <20011113104720.D5446@csr-pc1.zib.de>
In-Reply-To: <001a01c16ba7$ab5242d0$010411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001a01c16ba7$ab5242d0$010411ac@local>; from manfred@colorfullife.com on Mon, Nov 12, 2001 at 07:27:14PM +0100
X-www.distributed.net: 27 OGR packets (3.56 Tnodes) [4.21 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 07:27:14PM +0100, Manfred Spraul wrote:
> The latency you talk about is the time required to schedule - there is nothing
> you driver can do to reduce that - syscall, signal or your own code must wait
> until schedule() decides to run your process.
> 
> I'd try to
> a) switch your process to realtime priority, mlockall your app.
> b) use the low-latency patches. They were regularly discussed on
> linux-kernel, search through the archives.
i'll definitely hav a look at these patches, thanks

> 
> Are you sure you need 10 to 20 usec? Then a hard realtime with everything
> in kernel is your only option, i.e. rtlinux.
Yes I'm sure and no, I don't think rtlinux is necessary, see my post answering
Richard.

thanks again, maybe the ll-patches and some priority shifting is all I need
_sh_

