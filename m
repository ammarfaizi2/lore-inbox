Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVATEiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVATEiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 23:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbVATEiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 23:38:25 -0500
Received: from lakermmtao03.cox.net ([68.230.240.36]:46011 "EHLO
	lakermmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262044AbVATEiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 23:38:16 -0500
In-Reply-To: <ufad5w07s93.fsf@epithumia.math.uh.edu>
References: <Pine.LNX.4.30.0501191309500.20626-100000@swamp.bayern.net> <ufad5w07s93.fsf@epithumia.math.uh.edu>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <18FE8C24-6A9D-11D9-A93E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Christoph Hellwig <hch@infradead.org>, Adam Radford <aradford@amcc.com>,
       Peter Daum <gator@cs.tu-berlin.de>, linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: 3ware driver (3w-xxxx) in 2.6.10: procfs entry
Date: Wed, 19 Jan 2005 23:38:14 -0500
To: Jason L Tibbitts III <tibbs@math.uh.edu>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 19, 2005, at 21:23, Jason L Tibbitts III wrote:
>>>>>> "PD" == Peter Daum <gator@cs.tu-berlin.de> writes:
> You should report the problems you find to them.  They do indicate (in
> the knowledge base on their web site) that you're going to need the
> in-engineering files to run on the latest kernels.  It's only recently
> that the newer tools acquired the ability to control older
> controllers.
>
> According to a recent post from a 3ware employee on linux-ide-arrays,
> a proper release is expected in February.  Obviously the best solution
> is that they just give us the source to these tools so that we can fix
> them ourselves.  Knowing that isn't going to happen I'm happy they're
> at least giving us something while they catch up with the speed of
> kernel progress.
>
> I can verify the fact that info is busted when the controller is
> verifying the array; I'll gather some more info and pass this on to
> 3ware.

We have some 3ware 7000 ATA-RAID controllers that I've tested with  
various
versions of the tools trying to get them to work:
+---------------+--------------- 
+--------------------------------------------+
| Kernel        | CLI Utility   | Functionality/Limitations              
      |
+---------------+--------------- 
+--------------------------------------------+
|               | 7000 - Stable | Works great, everything OK (Of course  
:-D) |
| Debian 2.4.28 |               |                                        
      |
|               | 7000 - In-Eng | [N/A] No such tool exists!             
      |
+---------------+--------------- 
+--------------------------------------------+
|               | 7000 - Stable | Works ok, except some operations fail  
with |
|               |               | unusual errors, and the info stuff  
doesn't |
|               |               | really work properly                   
      |
|               |               |                                        
      |
|               | 7000 - In-Eng | [N/A] No such tool exists!             
      |
|               |               |                                        
      |
|               | 9000 - Stable | Works great, everything OK, although  
some  |
|               |               | operations have status errors, though  
they |
|               |               | still function as expected.  This one  
has  |
| Debian 2.6.8  |               | an interesting new interface that I  
like.  |
|               |               |                                        
      |
|               | 9000 - In-Eng | This one lacks the new interface that  
is   |
|               |               | present in the tested release, which  
is    |
|               |               | kind of weird, given that it is a  
much     |
|               |               | newer version.  It also appears to  
work    |
|               |               | great on the 3ware 7000 card, but  
without  |
|               |               | the weird errors that plagued the  
stable   |
|               |               | tool.  This looks promising, but I  
kinda   |
|               |               | liked the interface of the 9000 tool.  
      |
+---------------+--------------- 
+--------------------------------------------+

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r   
!y?(-)
------END GEEK CODE BLOCK------


