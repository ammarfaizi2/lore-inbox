Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbUK2S0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUK2S0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 13:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbUK2S0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 13:26:11 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:11163 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261462AbUK2S0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 13:26:10 -0500
Subject: Re: MTRR vesafb and wrong X performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041129173419.GC26190@bytesex>
References: <1101338139.1780.9.camel@PC3.dom.pl>
	 <20041124171805.0586a5a1.akpm@osdl.org>
	 <1101419803.1764.23.camel@PC3.dom.pl> <87is7ogb93.fsf@bytesex.org>
	 <20041129154006.GB3898@redhat.com> <20041129162242.GA25668@bytesex>
	 <20041129165701.GA903@redhat.com>  <20041129173419.GC26190@bytesex>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101748942.21239.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 29 Nov 2004 17:22:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-29 at 17:34, Gerd Knorr wrote:
> Thats kida silly, but as I've found some simliar construct in the old
> code I left it in to avoid breaking stuff.  Guess there is a reason that
> this was there.  I'll take that as proof that broken BIOSes exist which
> don't fill screen_info.lfb_size correctly ;)

Indeed. Also some report less than the full amount because they only
support VGA modes in the lower bits of memory and others like Intel
ICH/GCH based systems report 1Mb because in essence the question has no
right answer.

> Maybe it works better to walk the PCI device list, find the correct
> gfx card using the framebuffer start address, then double-check the
> size by looking at the PCI ressources?

Very very few cards have a PCI resource map that gives useful size
information because they have apertures and are sometimes also windowed
or not all CPU accessible.

