Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262293AbRERL3D>; Fri, 18 May 2001 07:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262295AbRERL2y>; Fri, 18 May 2001 07:28:54 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:47883 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262294AbRERL2j>; Fri, 18 May 2001 07:28:39 -0400
Subject: Re: [patch] 2.4.0, 2.2.18: A critical problem with tty_io.c
To: alborchers@steinerpoint.com
Date: Fri, 18 May 2001 12:25:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        macro@ds2.pg.gda.pl, tytso@mit.edu, pberger@brimson.com (Peter Berger)
In-Reply-To: <3B04E694.34FA158F@steinerpoint.com> from "Al Borchers" at May 18, 2001 04:08:36 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150iOA-0006z3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Where is an example of the "other locking fix styles" that you and Ted want
> to apply to the serial drivers?
> I would be interested to try to figure this out and fix it--can you give
> me more of an idea of what the problem is?

Add an 'owner' field to the objects we are using. Then we can lock the tty
and the ldisc from the tyy_io code rather than in serial.c and friends. This
removes the unload during open/close races we currently have in serial.c

Take a look at videodev.c for a fairly clear example.

Alan


