Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272928AbTG3PS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 11:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272921AbTG3PQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 11:16:53 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:9215 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S272928AbTG3PQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 11:16:36 -0400
Date: Thu, 31 Jul 2003 01:16:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: clepple@ghz.cc, linux-kernel@vger.kernel.org
Subject: Re: [REPOST] "apm: suspend: Unable to enter requested state" after
 2.5.31 (incl. 2.6.0testX)
Message-Id: <20030731011651.618aba1e.sfr@canb.auug.org.au>
In-Reply-To: <1059576198.8041.46.camel@dhcp22.swansea.linux.org.uk>
References: <28705.216.12.38.216.1059490232.squirrel@www.ghz.cc>
	<1059491223.6094.6.camel@dhcp22.swansea.linux.org.uk>
	<32460.216.12.38.216.1059494755.squirrel@www.ghz.cc>
	<1059502242.5987.24.camel@dhcp22.swansea.linux.org.uk>
	<20030730110548.73919ca0.sfr@canb.auug.org.au>
	<1059576198.8041.46.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jul 2003 15:43:18 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Mer, 2003-07-30 at 02:05, Stephen Rothwell wrote:
> > > It might be 0x00009300, it might be set already, or it might be some other
> > > effect thats breaking your laptop of course
> > 
> > The 0 above initialises the base and limit parts of the descriptor and
> > should be zero as it is filled in later (or should be).
> 
> I thought the descriptor bits came in the first long word and the 16bit
> base/limit in the second ?

Not according to my book ... parts of the base and limit are spread around
in the second long word.

The 2.4 version of this is static in arch/i386/kernel/head.S and looks
like this:

        .quad 0x0040920000000000        /* 0x40 APM set up for bad BIOS's */

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
