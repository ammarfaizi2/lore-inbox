Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTICNaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbTICNaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:30:23 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54411 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262129AbTICNaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:30:21 -0400
Date: Wed, 3 Sep 2003 14:29:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Kars de Jong <jongk@linux-m68k.org>,
       Linux/m68k kernel mailing list 
	<linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030903132932.GA21530@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309031407050.20748-100000@serv> <Pine.GSO.4.21.0309031436020.6985-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309031436020.6985-100000@waterleaf.sonytel.be>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> > BTW the 020/030 caches are VIVT (and also only writethrough), the 040/060 
> > caches are PIPT.
> 
> That explains a bit. But the '060 stores are coherent, while the '040 stores
> aren't.

The L1 cache is coherent on the '040 according to the results.  It's
the store buffer snooping which fails.  Presumably the CPU core is
looking ahead at recent writes comparing just virtual addresses.

-- Jamie
