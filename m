Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286261AbRLTPA3>; Thu, 20 Dec 2001 10:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286266AbRLTPAJ>; Thu, 20 Dec 2001 10:00:09 -0500
Received: from cc5993-b.ensch1.ov.nl.home.com ([212.204.161.160]:7172 "HELO
	packetstorm.nu") by vger.kernel.org with SMTP id <S286261AbRLTPAF>;
	Thu, 20 Dec 2001 10:00:05 -0500
Reply-To: <alex@packetstorm.nu>
From: "Alex" <alex@packetstorm.nu>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: "Lkml" <linux-kernel@vger.kernel.org>
Subject: RE: Consistant complete deadlock with kernel 2.4.16 on an Abit VP6 with dual 1 Gig CPUs and an ICP GDT RAID card 
Date: Thu, 20 Dec 2001 16:00:03 +0100
Message-ID: <IOEMLDKDBECBHMIOCKODOEPICCAA.alex@packetstorm.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <24576.1008857426@ocs3.intra.ocs.com.au>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 i am having exactly the same problem! One of my servers
locks up once in a while and i was reading your post and i thought it might
be
the same problem with me, and it indeed is.

The server consists of:

Supermicro 370DLE motherbord
Dual 1Ghz Pentium III CPU's
1.5 Gig memory (highmem enabled)
2 ide software raid-0's and a scsi linux disk.

My systems also hangs after a short while when running such a script.
And it just hangs in the same way every now and then (mostly after 1 to 2
weeks
uptime). The HDD-led burns constantly when the system locks up.
SysRq aint responding when it locks up neither.

I have not been able to try without SMP support yet, altho i will (hopefully
today)
test it. I have been having this problem for a some time now and did not
solve it yet.
I will aslo try the nmi_watchdog=1 and kdb, if i get some more information i
will mail it.


--
	Alex (alex@packetstorm.nu)

On Thursday, December 20, 2001 3:10 PM,
"Keith Owens" <kaos@ocs.com.au> wrote:
>
> On Wed, 19 Dec 2001 16:22:47 -0500,
> "T. A." <tkhoadfdsaf@hotmail.com> wrote:
> >    Anyone know how I could debug the cause of this problem?  Machine
> >deadlocks.  Not even an Ooops so I'm short on ideas on how to track the
> >problem down.  Please help.  8-(  My new SMP system sucks on Linux.  8-(
>
> Compile for SMP and boot with nmi_watchdog=1.  If the problem is
> hardware that will not help.  If the problem is a software loop in
> kernel space (much more likely) then the nmi watchdog will trip after 5
> seconds.
>
> You might also find the kernel debugger to be useful,
> ftp://oss.sgi.com/projects/kdb/download/ix86.  See Documentation/kdb
> for man pages.  Using the pause key on a PC keyboard or control-A on a
> serial console will drop into kdb, unless the kernel has stopped
> processing interuupts, in which case the nmi watchdog should trip and
> drop you into kdb.
>
> For all low level debugging, I strongly recommend a serial console so
> you can capture the output on another system, see
> Documentation/serial-console.txt.
>



