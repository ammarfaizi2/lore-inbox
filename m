Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTDGFnD (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 01:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTDGFnD (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 01:43:03 -0400
Received: from rth.ninka.net ([216.101.162.244]:44422 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263263AbTDGFnC (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 01:43:02 -0400
Subject: Re: [sparc64] 2.4.21-pre7 and alsa: unresolved symbol
From: "David S. Miller" <davem@redhat.com>
To: Fabio Massimo Di Nitto <fabbione@fabbione.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0304061640140.7051@mazinga.int.fabbione.net>
References: <Pine.LNX.4.53.0304061640140.7051@mazinga.int.fabbione.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049694872.5415.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 22:54:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 07:52, Fabio Massimo Di Nitto wrote:
> 	Im a bit new to sparc kernel/hardware and I have been hitten by a
> problem compiling alsa modules.
> In a few words loading the modules i get the following error:
> 
> mazinga:/usr/src/modules/alsa-driver# insmod snd-page-alloc
> Using /lib/modules/2.4.21-pre7/kernel/sound/acore/snd-page-alloc.o
> /lib/modules/2.4.21-pre7/kernel/sound/acore/snd-page-alloc.o: unresolved
> symbol virt_to_bus_not_defined_use_pci_map

This symbol must never be referenced on the sparc64 platform,
it indicates non-portable code.

The 2.5.x ALSA code does not have this problem, so presumably the
current 2.4.x backport of ALSA has this bug fixed as well.

-- 
David S. Miller <davem@redhat.com>
