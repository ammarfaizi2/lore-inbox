Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbTDIKJd (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 06:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTDIKJd (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 06:09:33 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:25296 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262984AbTDIKJc (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 06:09:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16019.62440.828553.117381@gargle.gargle.HOWL>
Date: Wed, 9 Apr 2003 12:20:24 +0200
From: mikpe@csd.uu.se
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mikpe@csd.uu.se, Kaj-Michael Lang <milang@tal.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linuxppc-dev@lists.linuxppc.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre7
In-Reply-To: <1049882960.559.35.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.53L.0304041815110.32674@freak.distro.conectiva>
	<00b101c2fdeb$e1aa6e20$56dc10c3@amos>
	<16019.60959.273586.121431@gargle.gargle.HOWL>
	<1049882960.559.35.camel@zion.wanadoo.fr>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt writes:
 > On Wed, 2003-04-09 at 11:55, mikpe@csd.uu.se wrote:
 > > Kaj-Michael Lang writes:
 > >  > > So here goes -pre7. Hopefully the last -pre.
 > >  > >
 > >  > Won't compile for my PPC:
 > >  > ---
 > >  >         -o vmlinux
 > >  > drivers/ide/idedriver.o(.text+0x1a544): In function `pmac_outbsync':
 > >  > : undefined reference to `io_flush'
 > >  > drivers/ide/idedriver.o(.text+0x1a544): In function `pmac_outbsync':
 > >  > : relocation truncated to fit: R_PPC_REL24 io_flush
 > > 
 > > Someone updated pmac.c without testing it: io_flush() doesn't exist
 > > in 2.4.21-pre. Based on the diff from -pre6 to -pre7, I'd say the
 > > following is a reasonable approximation. My PM4400 runs with this
 > > patch right now.
 > 
 > Or just get my devel rsync.
 > 
 > Actually, what happened is that Marcelo took the version that was
 > in -ac tree, which I sent to Alan a while ago and is now outdated.
 > The io_flush macro was something I added to the arch includes and
 > later removed as I fixed the problem differently.
 > 
 > Marcelo: I sent you a fixed version, please do not apply this patch
 > but rather the one I sent you.

Ok, I can understand what happened, but shouldn't these fixes be
cc:d to or at last announced on LKML as well? It could be a month
before Marcelo does a -pre8 or -rc1.
