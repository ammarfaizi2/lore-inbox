Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWDMLQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWDMLQt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 07:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWDMLQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 07:16:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:13285 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964883AbWDMLQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 07:16:48 -0400
Message-ID: <1624893.1144927001987.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
Date: Thu, 13 Apr 2006 13:16:41 +0200 (CEST)
From: Oliver Weihe <o.weihe@deltacomputer.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: Re: Opteron 128GB NODMAPSIZE too small?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200604121946.59895.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-295-smp i386 (JVM 1.3.1_13)
Organization: Delta Computer Products GmbH
References: <7986404.1144863211340.SLOX.WebMail.wwwrun@exchange.deltacomputer.de> <200604121946.59895.ak@suse.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:62e2eaa30f0557f14c09a5fa777a0a78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andi,

thx for your quick reply.

> > While running SuSE Linux 10.0 (x86_64) with a vanilla 2.6.16.1 on an
> > 8way (8 sockets) Opteron equipped with 128GB (16GB per socket) of
> > memory
> > I found this in dmesg.
> > 
> > Any guesses to which value I should set NODEMAPSIZE?
> > Currently it is 0xfff (from 'include/asm-x86_64/mmzone.h')
> 
> 0x2fff. Or update to a newer kernel - it should
> have that problem fixed by finding a better hash shift that works
> with a smaller table too.

A newer Kernel (vanilla 2.6.16.5) doens't solve the problem (hash-shift
is still 25bit and with the default 12bit (0xfff) in NODEMAPSIZE there
is still one bit missing to adress the whole memory).
Anyway, increasing NODEMAPSIZE solves the problem. I wanted to ask you
before doing this because I'm not familar with the code and can't imagin
if this has any sideeffects.

Regards,
  Oliver Weihe

