Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbRERI1e>; Fri, 18 May 2001 04:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262279AbRERI1Y>; Fri, 18 May 2001 04:27:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:523 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262276AbRERI1P>; Fri, 18 May 2001 04:27:15 -0400
Subject: Re: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 18 May 2001 09:24:22 +0100 (BST)
Cc: alborchers@steinerpoint.com, alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl, tytso@mit.edu,
        pberger@brimson.com (Peter Berger)
In-Reply-To: <E150f2E-0006oP-00@the-village.bc.nu> from "Alan Cox" at May 18, 2001 08:50:53 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150fYc-0006qG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > drivers and fix their open/close routines to work with this patch?  Peter
> > and I can take some time to do that--if that would help.
> 
> That would be one big help. Having done that I'd like to go over it all with
> Ted first (if he has time) before I push it to Linus

So I stuck my justify this change to Ted hat on. And failed. 

For one the cleanest way to handle all the locking is to propogate the other
locking fix styles into both the ldisc and serial drivers. At least for 2.4
until the 2.5 folks get their deep magic inactivity based clean up working

The advantage of doing that is that modules that do play with use counts will
not do anything worse than they do now, and will remain fully compatible.

The ldisc race is also real and completely unfixed right now.

Alan

