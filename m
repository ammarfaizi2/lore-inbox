Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129440AbRBIP2Z>; Fri, 9 Feb 2001 10:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129519AbRBIP2Q>; Fri, 9 Feb 2001 10:28:16 -0500
Received: from ASt-Lambert-101-2-1-45.abo.wanadoo.fr ([193.251.59.45]:62456
	"EHLO zeus.itipi") by vger.kernel.org with ESMTP id <S129440AbRBIP2B>;
	Fri, 9 Feb 2001 10:28:01 -0500
Message-ID: <3A840D25.2010106@altern.org>
Date: Fri, 09 Feb 2001 16:30:45 +0100
From: basiltiK <sec@altern.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac2 i686; en-US; 0.7) Gecko/20010105
X-Accept-Language: en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Panic in 2.2.2-pre2 SMP several panics
In-Reply-To: <3A840590.11464.D9B937@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I don't really now if my problem is related with this one, and I 
(unfortunetly) don't have any Oops output to show - sorry 'bout that.
I'm even not sure this report will be helpful but... anyway

I'm currently running Linux amethyste 2.4.1-ac2 #1 Mon Feb 5 20:38:39 
CET 2001 i686  on a Compaq DL360, compiled with recommended (egcs 1.1.2 
release).
I need 2.4.x for netfilter and I'm currently doing MASQ, NAT and packet 
filtering.



I've tried 2.4.0-test12; 2.4.0; 2.4.1;  without beiing able to get a  
 >10 days uptime. The problem is always the same one :
   "sshing" my router box, then detarring a big tar.gz archive (such as 
egcs-xxx.tar.gz) make randomly oops my kernel (gzip is always the 
"faulty" process causing the Oops).

Sorry, but I haven't any Oops since it's a production machine, and I 
couldn't take the time to copy the Oops by hand.

UP 100/550 PIII processor, 128M of ram

lspci :

00:00.0 Host bridge: ServerWorks CNB20HE (rev 05)
00:00.1 Host bridge: ServerWorks CNB20HE (rev 05)
00:01.0 RAID bus controller: Symbios Logic Inc. (formerly NCR): Unknown 
device 0010 (rev 02)
00:03.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC 
215IIC [Mach64 GT IIC] (rev 7a)
00:04.0 System peripheral: Compaq Computer Corporation Advanced System 
Management Controller
00:05.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] 
(rev 74)
00:0f.0 ISA bridge: ServerWorks OSB4 (rev 4f)
00:0f.1 IDE interface: ServerWorks: Unknown device 0211
03:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)
03:05.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] 
(rev 08)

Unfortunetly, 2 intel NIC onboard :-(

   -uptime:
4:58pm  up 3 days,  4:57,  1 user,  load average: 0.00, 0.00, 0.00

This machine acts as a router.

   -RedHat 7.0 without any upgrade (bad glibc) with kernels  
2.4.0-test12; 2.4.0; 2.4.1
 
   -RedHat 7.0 with upgrades with 2.4.1-ac2
   -glibc 2.2.1 installed by hand
   -all recommended software in linux/Documentation/Changes


*Here is my question* :

   -Does the glibc version has an impact on the kernel' stability?
 

Thanks for your time,

b.


Stephen Carr wrote:

> Dear Kernel Gurus
> 
> Sorry if this is a bit of a repeat - I think the prior message was 
> incorrectly addressed.
> 
> System Dual 500 Mhz Pentium III 256MB ram with Adaptec 2940 
> UW scsi controller - WD disc and HP DAT tape.
> 
> I have been getting kernel panics when doing backups over the 
> network. I have used both the eepro100 driver and Intel's e100 driver 
> the general type of error is a panic - Aiee -- killing the interrupt 
> driver.
> 
> I have tried the 2.4.0, 2.4.1 and lately the 2.2.2-pre2 kernels.
> 
> Panics below for 2.4.2-pre2 kernel.
> 
> The error I have got is spkput:over: d0826d4b put:1514 dev:eth0 
> kernel BUG at skbuff.c:93 using the e100 driver
> 
> The NIC is an Intel Ether ExpressPro 100 set to 100Mbs full duplex 
> connected to an HP2424M switch.
> 
> I switched to the eepro100 drive and got this panic with system 
> "idle" and I was typing sudo -s.
> 
> Unable to handle kernel paging request at virtual address 18000080 
> Bad EIP value. Killing the interrupt handler.
> 
> Any ideas?
> 
> Stephen Carr
> 
> 
> -----------------
> Computing Officer
> Department of Civil and Environmental Engineering
> University of Adelaide
> Adelaide, South Australia,
> Australia 5005
> Phone +618 8303-4313
> Fax   +618 8303-4359
> Email sgcarr@civeng.adelaide.edu.au
> -----------------------------------------------------------
> This email message is intended only for the addressee(s)
> and contains information which may be confidential and/or
> copyright.  If you are not the intended recipient please
> do not read, save, forward, disclose, or copy the contents
> of this email. If this email has been sent to you in error,
> please notify the sender by reply email and delete this
> email and any copies or links to this email completely and
> immediately from your system.  No representation is made
> that this email is free of viruses.  Virus scanning is
> recommended and is the responsibility of the recipient.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
