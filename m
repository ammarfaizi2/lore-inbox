Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRA3TVl>; Tue, 30 Jan 2001 14:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130026AbRA3TVc>; Tue, 30 Jan 2001 14:21:32 -0500
Received: from ppp11-pool1c.bham.zebra.net ([209.12.6.202]:4996 "HELO
	bliss.penguinpowered.com") by vger.kernel.org with SMTP
	id <S129143AbRA3TVZ>; Tue, 30 Jan 2001 14:21:25 -0500
Date: Tue, 30 Jan 2001 13:12:19 -0600
From: "Forever shall I be." <zinx@magenet.com>
To: Davy Preuveneers <davy.preuveneers@student.kuleuven.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Parallel zip-disk can't use EPP 32 bit with 2.4.x kernels
Message-ID: <20010130131219.A13071@bliss.zebra.net>
In-Reply-To: <Pine.LNX.4.21.0101301846510.812-100000@scoezie.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0101301846510.812-100000@scoezie.kotnet.org>; from davy.preuveneers@student.kuleuven.ac.be on Tue, Jan 30, 2001 at 07:17:28PM +0100
X-GPG-Fingerprint: 1A27 513C 33D0 4DB6 BBDD  E891 4E64 FCAA 7455 8D71
X-GPG-Public-Key: http://pgp5.ai.mit.edu:11371/pks/lookup?op=get&search=0x74558D71
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2001 at 07:17:28PM +0100, Davy Preuveneers wrote:
> Since I'm running the 2.4.x kernels, I'm having a little problem with my
> parallel zip-disk. The ppa module can't use the EPP 32 protocol and uses
> the PS/2 protocol instead (which is much slower), as shown by the boot
> message of kernel 2.4.1:
> 
[snip]
> 
> Kernels 2.2.x use the EPP 32 bit protocol while the 2.4.x versions don't,
> although I have used the same options when compiling the new 2.4.1 kernel.
> When I change the parallel port configuration in the BIOS from ECP/EPP to
> EPP only (version 1.9), the 2.4.x kernels use the EPP 32 bit protocol as 
> well, but then I can't use ECP with dma anymore.
> 
> Does anyone know what the problem is?

Are you sure you've given parport_pc the correct IRQ/DMA? It doesn't
seem to be able to detect them very well over here, so I need a line
such as:
	options parport_pc io=0x378 irq=7 dma=3

but YMMV :)

> 
> Davy

-- 
Zinx Verituse                           (See headers for gpg key info)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
