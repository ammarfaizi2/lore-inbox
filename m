Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318300AbSHUOHf>; Wed, 21 Aug 2002 10:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318332AbSHUOHf>; Wed, 21 Aug 2002 10:07:35 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:53924 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S318325AbSHUOHd>; Wed, 21 Aug 2002 10:07:33 -0400
Date: Wed, 21 Aug 2002 15:39:17 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Mukesh Rajan <mrajan@ics.uci.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: detecting hard disk idleness
Message-ID: <20020821153917.B1444@linux-m68k.org>
References: <Pine.SOL.4.20.0208202316380.20323-100000@hobbit.ics.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.20.0208202316380.20323-100000@hobbit.ics.uci.edu>; from mrajan@ics.uci.edu on Tue, Aug 20, 2002 at 11:25:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 11:25:11PM -0700, Mukesh Rajan wrote:
> hi,
> 
> i'm trying to implement an alogrithm that requires as input the idleness
> period of a hard disk (i.e. time between satisfying a request and arrival
> of new request).
> 
> so far implementation polls "proc/stat" periodically to detect idleness
> over the poll period. this implementation is not accurate and also i have
> very small poll interval (milli secs). with some measurements, conclusion
> is that implementation is consuming quite some power. this millisecond
> polling overhead could be avoided if i can come up with an interrupt
> driven implementation. in DOS, i would have manipulated the interrupt
> table and inserted my code for 13h (disk interrupt right?). this would
> help me do some preprocessing before the actual call to the hard disk
> (13h).
> 
> is this possible in any way in Linux? i.e. have the kernel inform a
> program when a hard disk interrupt occurs? either through interrupt
> manipulation or otherwise?

cat /proc/interrupts

Richard
