Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUIUQw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUIUQw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 12:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUIUQw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 12:52:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:32731 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267839AbUIUQwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 12:52:24 -0400
Subject: Re: journalling filesystems, linux 2.4.22, SATA drives
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: axboe@suse.de, Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       jgarzik@pobox.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4150485E.6000501@nortelnetworks.com>
References: <4150485E.6000501@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095781763.31269.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 21 Sep 2004 16:49:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-21 at 16:27, Chris Friesen wrote:
> use a journalled filesystem.  However the hardware guy says that turning off the 
> write cache also turns off the automatic error correction on writes, so the 
> write may return an error rather than being remapped silently.

I don't know how vendors handle this however he may be right, or it
may be vendor dependant. Have you asked which vendors do this and which
don't. Maybe you just need the right drive vendor. 

The Linux IDE layer will retry a failed write not sure about the 2.4.22
SATA code although the early versions probably were not business ready
anyway.

> What's the best way for me to deal with this?

For IDE you either

1. turn off write caching
2. buy a hardware raid card (which will turn off write caching or
   have battery backup or both 8))
3. accept that its unlikely to get burned in normal usage especially 
   with a UPS.

Alan

