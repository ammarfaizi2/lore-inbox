Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275381AbRIZRte>; Wed, 26 Sep 2001 13:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275383AbRIZRtZ>; Wed, 26 Sep 2001 13:49:25 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:20742 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275386AbRIZRtH>; Wed, 26 Sep 2001 13:49:07 -0400
Subject: Re: Locking comment on shrink_caches()
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 26 Sep 2001 18:40:15 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), davem@redhat.com (David S. Miller),
        bcrl@redhat.com, marcelo@conectiva.com.br, andrea@suse.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109261003480.8327-200000@penguin.transmeta.com> from "Linus Torvalds" at Sep 26, 2001 10:25:18 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15mIfQ-0001E5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	PIII:
> 		nothing: 32 cycles
> 		locked add: 50 cycles
> 		cpuid: 170 cycles
> 
> 	P4:
> 		nothing: 80 cycles
> 		locked add: 184 cycles
> 		cpuid: 652 cycles


Original core Athlon (step 2 and earlier)

nothing: 11 cycles
locked add: 22 cycles
cpuid: 67 cycles

generic Athlon is

nothing: 11 cycles
locked add: 11 cycles
cpuid: 64 cycles


I don't currently have a palomino core to test

Wait for AMD to publish graphs of CPUid performance for PIV versus Athlon 8)


Alan
