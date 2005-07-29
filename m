Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVG2Ed2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVG2Ed2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 00:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbVG2Ed2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 00:33:28 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:55168 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262324AbVG2Ed1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 00:33:27 -0400
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: swsusp works (TP 600X) 
In-Reply-To: Your message of "Thu, 28 Jul 2005 23:55:48 +0200."
             <200507282355.49356.rjw@sisk.pl> 
Date: Fri, 29 Jul 2005 05:33:24 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1DyMYm-0001qX-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps the patch from Daniel Ritz to free the yenta IRQ on suspend
> (attached) will help?

Alas, when I went to apply it, patch said it was already there, and
sure enough 2.6.13-rc3-mm2 does have it.

One approach is to find out why PCMCIA cannot remove the socket power
when using cardctl eject (assuming that the error is related to the
swsusp failing).  The error is puzzling because physically ejecting
the card doesn't produce the message.  I'll try to chase that one
down, and welcome any hints on where to look or what debugging to turn
on.  I've looked in drivers/pcmcia/cs.c, which is where the error is
printed, but no enlightenment dawned, and will try setting pcmcia
debugging.

-Sanjoy
