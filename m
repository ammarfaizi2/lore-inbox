Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135996AbRDTTpr>; Fri, 20 Apr 2001 15:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135997AbRDTTpi>; Fri, 20 Apr 2001 15:45:38 -0400
Received: from chaos.analogic.com ([204.178.40.224]:28288 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S135996AbRDTTpd>; Fri, 20 Apr 2001 15:45:33 -0400
Date: Fri, 20 Apr 2001 15:44:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Victor Zandy <zandy@cs.wisc.edu>
cc: linux-kernel@vger.kernel.org, pcroth@cs.wisc.edu, epaulson@cs.wisc.edu
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <cpx3db3z8bv.fsf@goat.cs.wisc.edu>
Message-ID: <Pine.LNX.3.95.1010420153859.13120A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 2001, Victor Zandy wrote:

> 
> No dice.  Your program does not fix the problem.
> 
> If it were a hardware problem, I would expect the problem to occur
> under 2.4.2 as well as 2.2.*, and I would be surprised that we can
> consistently produce the behavior across our 64 node cluster.  But we
> are keeping the possibility in mind.
> 
> Thanks for your suggestions.
> 
> Vic
> 

Then, if the FPU is fine, you have just proven that the storage
where the FPU context is saved, gets overwritten. Further, once the
initial write occurs, all subsequent fnsave/frestore operations also
encounter the same spurious write. --OR some continuously-running
floating-point has sneaked into the kernel.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


