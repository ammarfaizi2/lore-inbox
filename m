Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264521AbTKNQxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 11:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264523AbTKNQxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 11:53:09 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:64786 "EHLO k2.dsa-ac.de")
	by vger.kernel.org with ESMTP id S264521AbTKNQxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 11:53:05 -0500
Date: Fri, 14 Nov 2003 17:53:00 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: ARM Linux kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Oops in flash
Message-ID: <Pine.LNX.4.33.0311141737560.2153-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

There once was a patch to the kernel to save Oops to diskets. I've done a
similar thing - for flash. You just reserve a small (smallest, normally,
128K) partition on flash and, when an Oops happens, it is just written to
it. Reasoning is simple - one can't always attach a serial console to all
systems, and not all bugs are so simple to reproduce. Then one could
write an init-script co check this partition, and if it not clean - save
contents and erase.

The patch is small and simple, one just has to find a suitable place for
it. Also, we don't set the oops_in_progress variable on ARM - it can be
quite nicely used for this purpose. Should we do it regardless?

If there is interest, I could clean it up and send to the list, although,
it is really trivial.

CC-ing to LKML, because other embedded (and not so embedded) systems might
also find this idea useful.

Yes, it is not so simple, if the oops happens in or during another access
to flash - I don't handle this...

Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany


