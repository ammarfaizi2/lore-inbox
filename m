Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315514AbSENIzK>; Tue, 14 May 2002 04:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315525AbSENIzK>; Tue, 14 May 2002 04:55:10 -0400
Received: from [202.88.159.197] ([202.88.159.197]:47861 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S315514AbSENIzI>; Tue, 14 May 2002 04:55:08 -0400
Message-Id: <200205140911.g4E9B7624219@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII
From: rpm <rajendra.mishra@timesys.com>
Reply-To: rajendra.mishra@timesys.com
Organization: Timesys
To: Russell King <rmk@arm.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ADS GCP reboots when running the application!
Date: Tue, 14 May 2002 14:41:06 +0530
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200205131138.g4DBcU526690@localhost.localdomain> <20020513173714.F6024@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 May 2002 10:07 pm, Russell King wrote:
> On Mon, May 13, 2002 at 05:08:30PM +0530, rpm wrote:
> >     The kernel is not showing any OOPS or panic  , it just reboots !
>
> Weird.  Tried any more recent kernels?
>
> > what i think is that some double fault ( fault inside fault handler )
>
> No such thing on ARMs.  If you take a fault while handling one, you
> re-enter the fault handler - you don't reboot.
>
  
What if the fault handler does a fault  ( like seg fault in seg fault handler 
)  , cause in i386, i remember such a situation causes a processor reboot as  
it becomes a infinite loop !

the same code works fine on an iPAQ  ! without any problems 
and i did a diff of the strace output on iPAQ and GCP and found that the 
following lines are extra in case of iPAQ while GCP reboots before it can 
print the lines !
***************************************
brk(0xc8000)                                         = 0xc8000     
close(4)                                                 = 0                
close(3)                                                = 0                   
munmap(0x40000000, 4096)                 = 0                   
_exit(0)                                                = ?

*****************************************
so i conclude that the system crashes in brk() sys call !

If you can point out  the cases where the kernel reboots without showing any 
message ,   then it will be easier to debug for me! 
and thanks a lot for the reply  :)  

rpm   
