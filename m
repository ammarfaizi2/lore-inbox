Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTLJJbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 04:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTLJJbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 04:31:01 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:38153 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S261953AbTLJJa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 04:30:59 -0500
Date: Wed, 10 Dec 2003 10:30:50 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Matthew Reppert <repp0017@tc.umn.edu>, <linux-kernel@vger.kernel.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [OOPS] 2.6.0-test11 sysfs
In-Reply-To: <20031209211440.A16651@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0312101027390.1130-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, Russell King wrote:

> On Tue, Dec 09, 2003 at 11:57:28AM -0600, Matthew Reppert wrote:
> > Try this patch. (Patrick, is this the sane thing to do? And is it worth
> > it? If so, I can do similar things to the other sysfs_create_* functions
> > if you would like.)
>
> Actually the "right" thing to do is to drop the file creation stuff from
> i82365; due to an interaction between sysfs and pcmcia, we can't register
> class device files in the initialisation path.

Without commenting on the "right thing to do", I can only witness, that
the patch from Matthew does remove the Oops (or at least I couldn't
reproduce it any more).

Also, Russell, as you are maintaining PCMCIA code as well, I might just
remind, that the i82365 driver doesn't have the release method, which
produces a nice kernel-message with a backtrace on unloading of the
module. Or does that driver have a separate maintainer?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

