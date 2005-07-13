Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262562AbVGMKal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262562AbVGMKal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVGMKak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:30:40 -0400
Received: from web26505.mail.ukl.yahoo.com ([217.146.176.42]:39057 "HELO
	web26505.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262562AbVGMKai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:30:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KXmy+WKesGg+vwrut7bhKLYSS0EtiRTJBW1aRytTNv2/86ixh1RAIWwCYUMgo5JmALxGJjeAiEPv4Nyd1WuLPC++ItOE8UTNBwBf86IzaYEdKjc1b2VTrrDhWqQSgEm/SfXAEt3Vmd9adi4P3OshtH+bRQEjC2ybkjVXcaVR7kY=  ;
Message-ID: <20050713103030.18442.qmail@web26505.mail.ukl.yahoo.com>
Date: Wed, 13 Jul 2005 12:30:30 +0200 (CEST)
From: karsten wiese <annabellesgarden@yahoo.de>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
To: charding@llnl.gov
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20050713063310.GA12661@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Ingo Molnar <mingo@elte.hu> schrieb:

> 
> hm, -28 is broken, and your patch is the only significant
> change:
> 
> ----- Forwarded message from Chuck Harding
> <charding@llnl.gov> -----
> 
> Date: Tue, 12 Jul 2005 14:01:04 -0700 (PDT)
> From: Chuck Harding <charding@llnl.gov>
> To: Linux Kernel Discussion List
> <linux-kernel@vger.kernel.org>
> Subject: Re: Realtime Preemption, 2.6.12, Beginners
> Guide?
> Cc: Ingo Molnar <mingo@elte.hu>
> 
> On Tue, 12 Jul 2005, Lee Revell wrote:
> 
> >On Mon, 2005-07-11 at 17:07 +0200, Ingo Molnar wrote:
> >>I've uploaded -27 with the fix - but it should
> >>only confirm that it's not a stack overflow.
> >
> >V0.7.51-28 does not compile:
> >
> > CC [M]  sound/oss/emu10k1/midi.o
> >sound/oss/emu10k1/midi.c:48: error: syntax error before
> '__attribute__'
> >sound/oss/emu10k1/midi.c:48: error: syntax error before
> ')' token
> >
> >Here's the offending line:
> >
> >   48 static DEFINE_SPINLOCK(midi_spinlock
> __attribute((unused)));
> >
> >Lee
> >
> 
> I got it to compile but it won't boot - it hangs right
> after the
> 'Uncompressing Linux... OK, booting the kernel' - I'm
> using .config
> from 51-27 (attached)
> 
Please unselect CONFIG_X86_IOAPIC_FAST and try 51-28 again.
Also please boot the newest "working for you" RT kernel
with the kernel parameter 'apic=debug' added. Post the
dmesg that you get right after boot.

    Karsten




	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
