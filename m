Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265267AbRF0GAc>; Wed, 27 Jun 2001 02:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265268AbRF0GAX>; Wed, 27 Jun 2001 02:00:23 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:4748 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265267AbRF0GAF>; Wed, 27 Jun 2001 02:00:05 -0400
Message-ID: <3B397659.816CF0A3@uow.edu.au>
Date: Wed, 27 Jun 2001 15:59:53 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Timmerman <Tim.Timmerman@asml.com>
CC: kees <kees@schoen.nl>, linux-kernel@vger.kernel.org
Subject: Re: NETDEV WATCHDOG with 2.4.5
In-Reply-To: <Pine.LNX.4.21.0106261924220.10865-100000@schoen3.schoen.nl>,
		<Pine.LNX.4.21.0106261924220.10865-100000@schoen3.schoen.nl> <15161.28095.801407.427346@asml.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Timmerman wrote:
> 
> >>>>> "kees" == kees  <kees@schoen.nl> writes:
> 
> kees> Hi,
> 
> kees> I tried 2.4.5 but after a couple of hours I lost all network
> kees> connectivety.  The log shows:
> <snip>
>         Can I just add a me too here ?
> 
>         System: Abit BP6, Dual Celeron, Ne2k-pci, usb ohci and
>         scanner; 128 Mb Ram, Nvidia TNT2 graphics. Kernel 2.4.5

ne2k and, to a lesser extent, 3c59x do not work correctly on many
x86 SMP machines because of a problem with the APIC interrupt
controller.

Probable fixes include booting with the `noapic' option,
running -ac kernels or applying Maciej's APIC workaround
patch.  There's a copy at http://www.uow.edu.au/~andrewm/linux/apic.txt
