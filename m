Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132717AbRDDHx4>; Wed, 4 Apr 2001 03:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132736AbRDDHxq>; Wed, 4 Apr 2001 03:53:46 -0400
Received: from [166.70.28.69] ([166.70.28.69]:11084 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S132717AbRDDHxh>;
	Wed, 4 Apr 2001 03:53:37 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: geert@linux-m68k.org (Geert Uytterhoeven),
        jsimmons@linux-fbdev.org (James Simmons),
        lk@tantalophile.demon.co.uk (Jamie Lokier),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        linux-fbdev-devel@lists.sourceforge.net (Linux Fbdev development list)
Subject: Re: [Linux-fbdev-devel] Re: fbcon slowness [was NTP on 2.4.2?]
In-Reply-To: <E14kPoq-0007w5-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Apr 2001 01:50:41 -0600
In-Reply-To: Alan Cox's message of "Tue, 3 Apr 2001 13:21:53 +0100 (BST)"
Message-ID: <m1lmphw1bi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > The MMX memcpy for CyrixIII and Athlon boxes is something like twice the
> > > speed of rep movs. On most pentium II/III boxes the fast paths for rep movs
> > > and for MMX are the same speed
> > 
> > As long as you are copying in real memory. So the PCI bus or the host bridge
> > implementation may be the actual limit.
> 
> The CyrixIII sits on the same host bridges as the intel processors

I don't know if it applies to this case but one thing I have seen make
a noticeable difference is whether or not write-combining is enabled.
If we have only be enabling MTRR's for intel this could do account
for it.

Eric
