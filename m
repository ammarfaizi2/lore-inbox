Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbTK2UA2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 15:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbTK2UA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 15:00:28 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:3200
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S262564AbTK2UA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 15:00:27 -0500
From: John Mock <kd6pag@qsl.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: swim3 testing [was: -test10/PPC still broken on PowerMac 8500]
References: <E1AOnxb-0001nF-00@penngrove.fdns.net>,<1069808393.671.87.camel@gaston>
Message-Id: <E1AQBGy-0000EN-00@penngrove.fdns.net>
Date: Sat, 29 Nov 2003 12:00:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, compare your current 'swim3.c' against 2.4.21/PPC and -test11/i386.
It generally reads the same floppies that the VAIO reads, and if it gets
errors, the Sony gets the same errors.  If anything, maybe because of a
better Mac floppy drive, it reads a few floppies the Sony cannot.  When
it does get errors, it reports them in the same manner as the current
i386 floppy driver (albeit on the one floppy that i had intentionally
created a bad track on for test purposes, they disagreed by one sector 
as exactly where the error occurred, which i'm not concerned about).

Comparing the your current driver against the 2.4.21 swim3 driver, the
error reporting is different and it takes much longer to report errors
under 2.4.21 (3 min. total vs. 40 sec total for my intentionally bad 
floppy), and 2.4.21 reports errors for each sector after the bad one, 
while the i386 and the current 'swim3' driver flag the first error and 
seem to discard the rest.

I can't say what the correct behavior is.  However, your current 'swim3'
driver seems to be more useful to me than the older one, and its behavior
is much closer to the current i386 driver (i.e. having more reproducible
results across platforms makes life easier for many people).

So aside from the losing video sync switching back from X, the PowerMac
8500 under -test10 seems to be alot better now, assuming your current
driver is acceptable for 2.6.0-test11.  (I wish i could say the same for
i386 software suspend, alas, but that'll just have to wait...)  Thanks 
again for the clues!
				 -- JM
