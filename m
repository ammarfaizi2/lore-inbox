Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbRE0RHr>; Sun, 27 May 2001 13:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262822AbRE0RHh>; Sun, 27 May 2001 13:07:37 -0400
Received: from [213.128.193.148] ([213.128.193.148]:23822 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id <S262821AbRE0RHZ>;
	Sun, 27 May 2001 13:07:25 -0400
Date: Sun, 27 May 2001 21:06:28 +0400
From: Oleg Drokin <green@linuxhacker.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: VIA IDE no go with 2.4.5-ac1
Message-ID: <20010527210628.A998@linuxhacker.ru>
In-Reply-To: <20010527144337.A15235@linuxhacker.ru> <E1543FE-0001zX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1543FE-0001zX-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, May 27, 2001 at 05:18:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, May 27, 2001 at 05:18:20PM +0100, Alan Cox wrote:
> >   Vanilla 2.4.5 boots ok, but 2.4.5-ac1 finishes kernel initialisation and
> >   starts to print "hda: lost interrupt", I guess this is related to VIA IDE
> >   updates in AC kernels. Config for vanilla and AC kernel is the same.
> >   Here are the kernel logs from 2.4.5 and 2.4.5-ac1 (collected with serial
> > ACPI: Core Subsystem version [20010208]
> > ACPI: Subsystem enabled
> > ACPI: Not using ACPI idle
> > ACPI: System firmware supports: S0 S1 S4 S5
> > hda: lost interrupt
> > hda: lost interrupt
> Does this still happen if you build without ACPI support. Also does
> 'noapic' have any impact ?
It does boot once I build without ACPI. (though vanilla 2.4.5 boots regardless
of that). It disabled DMA by default for some strange reason, so I get 2.5Mb/sec
instead of usual 35Mb/sec from my HDD.

BTW, 2.4.5-ac1 fails on unmounting reiserfs for me with this diagnostic:
journal_begin called without kernel lock held
kernel BUG at journal.c:423!
I've seen this was reported for 2.4.5, too.

Bye,
    Oleg
