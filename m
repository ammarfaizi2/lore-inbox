Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282511AbRLGPgu>; Fri, 7 Dec 2001 10:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282453AbRLGPgk>; Fri, 7 Dec 2001 10:36:40 -0500
Received: from mail.direcpc.com ([198.77.116.30]:5341 "EHLO
	postoffice2.direcpc.com") by vger.kernel.org with ESMTP
	id <S282062AbRLGPgY>; Fri, 7 Dec 2001 10:36:24 -0500
Subject: Re: kernel: ldt allocation failed
From: "Jeffrey H. Ingber" <jhingber@ix.netcom.com>
To: Kiril Vidimce <vkire@pixar.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0112062124440.18796-100000@tombigbee.pixar.com>
In-Reply-To: <Pine.LNX.4.21.0112062124440.18796-100000@tombigbee.pixar.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 00:58:33 -0500
Message-Id: <1007704718.10108.0.camel@eleusis>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem is very familiar.  It was fixed in an -ac patch against
2.4.9 (although I don't recall the exact one), and is included in
subsequent Linus kernels.  Without this fix, I experienced similar
problems with X on multiprocessor workstations.

Jeffrey H. Ingber (jhingber _at_ ix.netcom.com)

On Fri, 2001-12-07 at 00:40, Kiril Vidimce wrote:
> 
> We suddenly started seeing freezing problems on a number of machines
> in the past couple of days. There is no pattern as far as I can tell.
> It has happened while running OpenGL apps, netscape, or even when not 
> doing anything. The machine will usually just hang and while it's 
> still pingable, it's totally unresponsive and you can't remotely log in.
> The 2.4.3 kernel usually hangs forever; the machines with 2.4.9
> kernels usually come back within 10-15 secs.
> 
> Every time this happens we see the following message in the system log:
> 
> Dec  6 21:29:00 stranger kernel: ldt allocation failed
> 
> The machines are:
> 
> Hardware:
>     - IBM Intellistation M Pro 
>     - dual 2 GHz P4's
>     - 2 GB RAM
>     - NVIDIA Quadro DCC card
> 
> Software:
>     - Red Hat 7.1
>     - kernel 2.4.3smp or 2.4.9smp
>     - XFree 4.1
>     - Ximian Gnome 1.4
>     - NVIDIA drivers 1.0-1541
> 
> Once this problem occurs, even if the hang is temporary, the machine
> is extremely flakey. Almost any app will start causing ldt allocation
> failure messages in the system log. Only a reboot really helps.
> 
> Questions:
> - Does this ring a bell to anybody? What is ldt anyway and what would 
>   cause an allocation to fail?
> 
> - I still keep one of these messages in this state. Is there anything
>   I can probe to get useful debugging info?
> 
> Any help would greatly be appreciated.
> 
> Thanks,
> KV
> --
>   ___________________________________________________________________
>   Studio Tools                                        vkire@pixar.com
>   Pixar Animation Studios                        http://www.pixar.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


