Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130754AbQLUNxZ>; Thu, 21 Dec 2000 08:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131009AbQLUNxP>; Thu, 21 Dec 2000 08:53:15 -0500
Received: from 4dyn46.com21.casema.net ([212.64.95.46]:13330 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S130754AbQLUNxF>;
	Thu, 21 Dec 2000 08:53:05 -0500
Date: Thu, 21 Dec 2000 14:22:06 +0100
From: bert hubert <ahu@ds9a.nl>
To: sswapnee@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mount system call hangs up the system
Message-ID: <20001221142205.B31577@home.ds9a.nl>
Mail-Followup-To: sswapnee@in.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <CA2569BC.00442F0D.00@d73mta05.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <CA2569BC.00442F0D.00@d73mta05.au.ibm.com>; from sswapnee@in.ibm.com on Thu, Dec 21, 2000 at 05:47:10PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 05:47:10PM +0530, sswapnee@in.ibm.com wrote:
> Hello Everybody
> 
> I am trying to mount a filesystem on Linux 2.4.0-test10 kernel using the
> mount() function.
> When I call this function the system just hangs up.  I have to restart
> linux by switching off and on.
> Can somebody tell me why mount call just hangs?  Is there anyway to take a
> dump when
> the call is being executed.

If you have a second computer available, I highly recommend using kgdbstub
which can be found on sourceforge. This gives you source level debugging in
the kernel. Just put a breakpoint in sys_mount(), or whatever it is called
and see what happens.

Linus is dead set against using a debugger in daily development but it is a
very valuable tool for quickly gaining insight.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
