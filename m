Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264976AbTFVNTF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 09:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264982AbTFVNTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 09:19:05 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:52891 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S264976AbTFVNTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 09:19:04 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Isapnp warning
Date: Sun, 22 Jun 2003 15:34:02 +0200
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@digeo.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>, cw@f00f.org,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0306221029110.869-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0306221029110.869-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306221534.02518.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 June 2003 10:32, Geert Uytterhoeven wrote:
> On Sun, 22 Jun 2003, Paul Mackerras wrote:
> > Andrew Morton writes:
> > > Compared to 2.95.3, gcc-3.3 takes 1.5x as long to compile, and produces
> > > a kernel which is 200k larger.
> >
> > I just tried it on PPC.  Compared to 2.95.4, gcc-3.3 took 36% longer
> > to compile and produced a kernel which was 120k smaller.
>
> I have the same experience w.r.t. kernel size on MIPS, using 2.95.4 from
> Debian woody on the target, and 3.2.2 for cross-compiling.
>
> Perhaps the code increase is for CISC only?

In another branch of this thread Andrew said it's due to extra alignment 
padding (presumably with a view to improving execution speed) and Herbert Xu 
mentioned out-of-line conditional branch compilation, both of which sould 
reasonable to me.  They also sound like they could or should be trivially 
switchable.

Regards,

Daniel

