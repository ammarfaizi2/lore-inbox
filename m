Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266750AbRG3Nbl>; Mon, 30 Jul 2001 09:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268441AbRG3NbU>; Mon, 30 Jul 2001 09:31:20 -0400
Received: from ns.suse.de ([213.95.15.193]:56836 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S266750AbRG3NbO>;
	Mon, 30 Jul 2001 09:31:14 -0400
Date: Mon, 30 Jul 2001 15:31:17 +0200
From: Olaf Hering <olh@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new scsi hardware detection in 2.4.7(pre)
Message-ID: <20010730153117.A2142@suse.de>
In-Reply-To: <20010723171019.A18135@suse.de> <22072.995939994@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <22072.995939994@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Jul 24, 2001 at 11:59:54AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, Keith Owens wrote:

> On Mon, 23 Jul 2001 17:10:19 +0200, 
> Olaf Hering <olh@suse.de> wrote:
> >I get this on non-scsi systems with scsi compiled into the kernel:
> >
> >SCSI subsystem driver Revision: 1.00
> >request_module[scsi_hostadapter]: Root fs not mounted
> >request_module[scsi_hostadapter]: Root fs not mounted
> >request_module[scsi_hostadapter]: Root fs not mounted
> 
> The SCSI midlayer is trying to load the SCSI host adapter, that is an
> unavoidable side effect of including SCSI support.  Because no adapter
> is found, kmod tries to automatically load a module that can find a
> host adapter.  The "Root fs not mounted" message occurs when you try to
> load any module before / is mounted.

Does that make any sense? I mean, there are some scsi drivers, none of
them found a valid device, why do we look for more drivers? It would
make sense if there are no low level device drivers in the kernel
binary.


Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
