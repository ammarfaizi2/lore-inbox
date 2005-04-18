Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbVDREJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVDREJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 00:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbVDREJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 00:09:18 -0400
Received: from smtpout.mac.com ([17.250.248.45]:27073 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261645AbVDREIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 00:08:52 -0400
In-Reply-To: <200504172337.j3HNbJsA004220@laptop11.inf.utfsm.cl>
References: <200504172337.j3HNbJsA004220@laptop11.inf.utfsm.cl>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <edb06d05e65c7c2ce2ba008cc673aa29@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Andreas Hartmann <andihartmann@01019freenet.de>,
       linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: More performance for the TCP stack by using additional hardware chip on NIC
Date: Mon, 18 Apr 2005 00:08:41 -0400
To: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 17, 2005, at 19:37, Horst von Brand wrote:
> Andreas Hartmann <andihartmann@01019freenet.de> said:
>> Alacritech developed a new chip for NIC's
>> (http://www.alacritech.com/html/tech_review.html), which makes it 
>> possible
>> to take away the TCP stack from the host CPU. Therefore, the host CPU 
>> has
>> more performance for the applications according Alacritech.
>>
>> This sounds interesting.
>
> This idea has been discussed around here a couple of times, and the
> consensus is that it is a bad idea: IP (and upper protocol) processing
> is not expensive, if done right, so this really doesn't buy much; this
> forces a particular interface to networking into the kernel, loosing
> flexibility that way is always bad; there is no access to futzing
> around in between (for example, for firewalling and such); and if the
> "hardware implementation" has bugs, you are screwed.

What I think would be _much_ more useful is a generic low-power 
multi-proc
MIPS/PPC system on a PCI card with a certain amount of RAM, etc that 
could
be programmed at runtime by the master CPU.  Then you lose none of the
flexibility, it can be run in the same endian-mode as the host CPU, and 
it
would allow you to program it for much more complicated DMA.  You could 
do
anything from linux software RAID, audio processing, encryption, TCP/IP
stack acceleration, extra scatter-gather for your disk controller, etc.
If it was low-cost, IE: cheaper than adding extra full-speed CPUs to the
system, and using a decent bi-endian, vector-capable CPU (Like PPC), you
might find that people will buy them for the flexibility.  Such a thing
might also be useful for the prezero folks, it could be used (when not
otherwise occupied) for zeroing unused pages.

Personally, I think I'd buy one or two just to tinker with them :-D.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


