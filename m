Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316895AbSFFItu>; Thu, 6 Jun 2002 04:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSFFItt>; Thu, 6 Jun 2002 04:49:49 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:4624 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S316895AbSFFIts>; Thu, 6 Jun 2002 04:49:48 -0400
Message-ID: <3CFF22B2.5050004@loewe-komp.de>
Date: Thu, 06 Jun 2002 10:52:02 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Oliver Xymoron <oxymoron@waste.org>, Mark Mielke <mark@mark.mielke.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <Pine.LNX.4.44.0206051612170.2614-100000@waste.org> <E17FikY-0001fL-00@starship>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Wednesday 05 June 2002 23:22, Oliver Xymoron wrote:
> 
>>On Wed, 5 Jun 2002, Daniel Phillips wrote:
>>
>>
> 
>>Worst case for this is devices
>>queues for disks. Go through the thought experiment of what happens when
>>an RT task and a !RT task interleave disk access. Worse, what happens when
>>they're creating files (and all the locking that entails) in the same
>>directory.
>>
> 
> I mentioned somewhere that the realtime filesystem would get its own
> volume.  That's a big help, because it means that the entire filesystem
> can run in the RTOS, and we only have to worry about the block queue,
> which is an interesting and tractable problem from the realtime point
> of view.  Obviously, we want the RTOS to operate the block queue, and
> yes, we want it to be efficient.
> 
> Our current block queue design would benefit a lot from the kind of
> thinking that would be required to make it realtime.
> 
> 

You know that spinning disks do some recalibrations?

Whatever marketing tries to imply with "realtime volumes" - the
technology only tries to make better promises (think of AV disks
for better sustained rate).

LynxOS (now LynuxWorks) has some patents for priority based IO.
And yes, I know about "resource kernels" and alike.
But that does not count for spinning disks: they are *not* predictable.
And think about the shared bus like PCI - out of *hard realtime* when
not talking about worst cases in ranges of seconds.

