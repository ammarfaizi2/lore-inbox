Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbRDTTjG>; Fri, 20 Apr 2001 15:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131979AbRDTTi4>; Fri, 20 Apr 2001 15:38:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27264 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131974AbRDTTim>; Fri, 20 Apr 2001 15:38:42 -0400
Date: Fri, 20 Apr 2001 15:37:07 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Ulrich Drepper <drepper@cygnus.com>
cc: Victor Zandy <zandy@cs.wisc.edu>, linux-kernel@vger.kernel.org,
        pcroth@cs.wisc.edu, epaulson@cs.wisc.edu
Subject: Re: BUG: Global FPU corruption in 2.2
In-Reply-To: <m3n19bs7dn.fsf@otr.mynet.cygnus.com>
Message-ID: <Pine.LNX.3.95.1010420153006.12968A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Apr 2001, Ulrich Drepper wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
> 
> > If it "fixes" it, there is no problem with the FPU, but with the
> > 'C' runtime library which doesn't initialize the FPU to a known
> > state before it uses it.
> 
> It's the kernel which initializes the FPU.  This was always the case
> and necessary to implement the fast lazy FPU saving/restoring.
> Processes which never use the FPU never initialize it.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The kernel doesn't know if a process is going to use the FPU when
a new process is created. Only the user's code, i.e., the 'C' runtime
library knows. If the user is using 'asm' or whatever, the user must
initialize the FPU before using it, otherwise, the user doesn't know
anything about its state and the results ... (let's see, what was at
TOS, errm, is this a NAN?). The results are indeterminate.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


