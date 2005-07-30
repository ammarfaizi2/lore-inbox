Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVG3Bfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVG3Bfn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 21:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVG3Bfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 21:35:41 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:54832 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262897AbVG3Ber (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 21:34:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=J1qCHaDABPrSKgx4HB/7THUFn4Vd4CbdprU0lZqjcWLT4g7omhXhm9rrIwpEyr6ETvPH+ZEZKQr1PJZalogkvXztzJHyTGVlM4hQBV9igoGRpuoSMusBqhsUzki2jE/dYz1q4uFlb5jrj2pLa7Xhf1A4GF+/eGDgBtTbwCSVMTc=
Date: Sat, 30 Jul 2005 05:42:37 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Michael Thonke <iogl64nx@gmail.com>, Alexander Fieroch <fieroch@web.de>,
       linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, bzolnier@gmail.com, axboe@suse.de,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Natalie.Protasevich@unisys.com, Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: "drive appears confused" and "irq 18: nobody cared!"
Message-ID: <20050730014237.GA20131@mipter.zuzino.mipt.ru>
References: <d6gf8j$jnb$1@sea.gmane.org> <42EAAFD4.4010303@web.de> <42EAD086.4010904@gmail.com> <200507291905.37339.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507291905.37339.kernel-stuff@comcast.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 07:05:36PM -0400, Parag Warudkar wrote:
> On Friday 29 July 2005 20:57, Michael Thonke wrote:
> > do you run
> > A.) SATA in Enhanced Mode
> > B.) SATA+PATA or PATA operation mode?
> >
> > This problem I can reproduce when I ?set A.)+B.) in bios I
> > exactly get the same behavior of confused cd - drives.
> 
> I have this same problem on my laptop which doesn't have SATA.  In my case I
> get the problem if I run 2.6.12-gentoo-r6 - Problem doesnt happen with
> 2.6.12-gentoo-r4 - which just means that tracking the patch causing this
> problem will be simpler...

--- 2.6.12-r4.txt			[1]
+++ 2.6.12-r6.txt			[2]
+1003_linux-2.6.12.3.patch	<-----------------------+
+1370_sparc-modpost_stt_reg.patch			|
-1900_acpi-irq-0.patch			included in ----+
+2700_irqpoll.patch			[3]
	From: Alan Cox
	Subject: [PATCH] irqpoll
+2900_gameport-probe.patch

[1] http://dev.gentoo.org/~dsd/genpatches/patches-2.6.12-7.htm
[2] http://dev.gentoo.org/~dsd/genpatches/patches-2.6.12-10.htm
[3] http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=200803dfe4ff772740d63db725ab2f1b185ccf92;hp=21fe3471c3aaa5c489c5d3a4d705291eb7511248

