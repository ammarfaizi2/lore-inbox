Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265116AbSJWSVp>; Wed, 23 Oct 2002 14:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265123AbSJWSVp>; Wed, 23 Oct 2002 14:21:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:43398 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265116AbSJWSVo>; Wed, 23 Oct 2002 14:21:44 -0400
Date: Wed, 23 Oct 2002 14:30:22 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Nivedita Singhvi <niv@us.ibm.com>
cc: bert hubert <ahu@ds9a.nl>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       "David S. Miller" <davem@rth.ninka.net>, netdev@oss.sgi.com,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] tuning linux for high network performance?
In-Reply-To: <3DB6E56D.8D930A1D@us.ibm.com>
Message-ID: <Pine.LNX.3.95.1021023141949.15292A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, Nivedita Singhvi wrote:

> "Richard B. Johnson" wrote:
> 
> > No. It's done over each word (short int) and the actual summation
> > takes place during the address calculation of the next word. This
> > gets you a checksum that is practically free.
> 
> Yep, sorry, word, not byte. My bad. The cost is in the fact 
> that this whole process involves loading each word of the data
> stream into a register. Which is why I also used to consider
> the checksum cost as negligible. 
> 
> > A 400 MHz ix86 CPU will checksum/copy at 685 megabytes per second.
> > It will copy at 1,549 megabytes per second. Those are megaBYTES!
> 
> But then why the difference in the checksum/copy and copy?
> Are you saying the checksum is not costing you 864 megabytes
> a second??

Costing you 864 megabytes per second?
Lets say the checksum was free. You are then able to INF bytes/per/sec.
So it's costing you INF bytes/per/sec?  No, it's costing you nothing.
If we were not dealing with INF, then 'Cost' is approximately 1/N, not
N. Cost is work_done_without_checksum - work_done_with_checksum. Because
of the low-pass filter pole, these numbers are practically the same.
But, you can get a measurable difference between any two large numbers.
This makes the 'cost' seem high. You need to make it relative to make
any sense, so a 'goodness' can be expressed as a ratio of the cost and
the work having been done.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


