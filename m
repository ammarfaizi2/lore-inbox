Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSFTONC>; Thu, 20 Jun 2002 10:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSFTONB>; Thu, 20 Jun 2002 10:13:01 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27267 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S313698AbSFTOM7>; Thu, 20 Jun 2002 10:12:59 -0400
Date: Thu, 20 Jun 2002 10:14:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Abraham David Smith <abrahamsmith@students.wisc.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: machine hangs with journal and tulip error/bug message.
In-Reply-To: <20020620085130.A12938@euclid.dsl.wisc.edu>
Message-ID: <Pine.LNX.3.95.1020620100542.20681A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2002, Abraham David Smith wrote:

> 
> This is the first time I've reported what appears to be a kernel bug,
> so I apologize if the information I provide is insufficient or if my
> recipient is the wrong person.
> 
> The Problem in a nutshell: Machine locks up.  It can be remotely
> pinged, but keyboard and mouse show no response.  Kernel message dumps
> to screen, pertaining to tulip and journal code.  Has to be reset.
> 
[SNIPPED...]
> 
> Finally, what I deem the important part, is the message log at the
> time of failure.  Obviosuly the first 20 lines or so are just standard
> network traffic, but then....
> 
> [root@katie tmp]# tail -f /var/log/messages
> Jun 19 17:13:55 katie sshd(pam_unix)[1602]: session closed for user kt
> Jun 19 17:15:20 katie su(pam_unix)[1698]: authentication failure; logname=kt uid=500 euid=0 tty= ruser= rhost=  user=root
> Jun 19 17:15:30 katie su(pam_unix)[1699]: session opened for user root by kt(uid=500)
> Jun 19 17:15:39 katie su(pam_unix)[1699]: session closed for user root
> Jun 19 17:15:43 katie su(pam_unix)[1450]: session closed for user root
> Jun 19 17:19:09 katie sshd(pam_unix)[1781]: session opened for user root by (uid=0)
> Jun 19 17:19:33 katie sshd(pam_unix)[1839]: session opened for user root by (uid=0)
> Jun 19 17:21:49 katie sshd(pam_unix)[1923]: session opened for user kt by (uid=0)
> Jun 19 17:22:08 katie sshd(pam_unix)[1977]: session opened for user kt by (uid=0)
> Jun 19 17:23:14 katie sshd(pam_unix)[1839]: session closed for user root
> Jun 19 17:43:34 katie sshd(pam_unix)[2063]: session opened for user root by (uid=0)
> Jun 19 17:46:42 katie sshd(pam_unix)[2063]: session closed for user root
> Jun 19 17:46:46 katie sshd(pam_unix)[2144]: session opened for user root by (uid=0)
> Jun 19 18:14:16 katie sshd(pam_unix)[1977]: session closed for user kt
> Jun 19 20:03:12 katie sshd(pam_unix)[1923]: session closed for user kt
> Jun 19 20:31:16 katie portsentry[968]: attackalert: SYN/Normal scan from host: ppp-62-123-0-111.dial.ipervia.it/62.123.0.111 to TCP port: 23
> Jun 19 22:29:25 katie portsentry[968]: attackalert: SYN/Normal scan from host: 218.55.100.145/218.55.100.145 to TCP port: 21
> Jun 19 23:31:07 katie portsentry[968]: attackalert: SYN/Normal scan from host: 203.251.224.254/203.251.224.254 to TCP port: 21

In the above, is this normal? Lots of remote accesses by root and lots
of `su` by user kt?  If not, you have been 'rooted'.

> 
> Jun 20 04:02:14 katie syslogd 1.4.1: restart.
> Jun 20 05:06:43 katie portsentry[972]: attackalert: UDP scan from host:
 trigger.doit.wisc.edu/144.92.254.242 to UDP port: 68

Again, somebody from 144.92.254.242 may be attacking you by trying to
'connect' to the bootpc port, number 68.

> Jun 20 07:14:41 katie kernel: hde: timeout waiting for DMA
> Jun 20 07:14:41 katie kernel: ide_dmaproc: chipset supported
> ide_dma_timeout func only: 14
> Jun 20 07:14:41 katie kernel: blk: queue c0352ce8, I/O limit 4095Mb
> (mask 0xffffffff)
> Jun 20 07:14:41 katie kernel: hde: read_intr: status=0x51
> { DriveReady SeekComplete Error }
> Jun 20 07:14:41 katie kernel: hde: read_intr: error=0x04
> { DriveStatusError }
> Jun 20 07:14:41 katie kernel: hde: read_intr: status=0x51
> { DriveReady SeekComplete Error }

Looks like this drive can't handle DMA with whatever cable you've
got it connected with.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

