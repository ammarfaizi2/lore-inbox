Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263780AbRFMOQA>; Wed, 13 Jun 2001 10:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263806AbRFMOPu>; Wed, 13 Jun 2001 10:15:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6566 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263780AbRFMOPl>;
	Wed, 13 Jun 2001 10:15:41 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.30083.146128.113723@pizda.ninka.net>
Date: Wed, 13 Jun 2001 07:15:31 -0700 (PDT)
To: Keith Owens <kaos@ocs.com.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: <10347.992441517@ocs4.ocs-net>
In-Reply-To: <15143.29554.888847.108615@pizda.ninka.net>
	<10347.992441517@ocs4.ocs-net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens writes:
 > On Wed, 13 Jun 2001 07:06:42 -0700 (PDT), 
 > "David S. Miller" <davem@redhat.com> wrote:
 > >
 > >Keith Owens writes:
 > > > OTOH if any *.S code is compiled into a module then all symbols it
 > > > refers to must be EXPORT_SYMBOL_NOVERS().
 > >
 > >Why not just add --include modversions.h to the gcc command line to
 > >build it, why wouldn't this work?
 > 
 > Assembler code is not hooked into the generic module symbol version
 > handling.  Every .S rule is unique and I'm not going to change every
 > one.

Why not make a ASM_CPP_DEFINES that all those rules use?

Surely this is a smaller hammer than making them all NOVERS(), I
think all of these workarounds with novers for assembly are silly and
are merely looking for a solution which nobody (perhaps except me :-)
is bothering to look for.

Later,
David S. Miller
davem@redhat.com
