Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266501AbUBDUWI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266475AbUBDUWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:22:01 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:48841 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266496AbUBDUVv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:21:51 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Torin Ford <tford@onyx.boisestate.edu>
Subject: Re: Missing IDE Devices in 2.6.2
Date: Wed, 4 Feb 2004 21:25:51 +0100
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.44.0402041257140.32552-101000@onyx.boisestate.edu>
In-Reply-To: <Pine.LNX.4.44.0402041257140.32552-101000@onyx.boisestate.edu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200402042125.51072.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 of February 2004 21:01, Torin Ford wrote:
> I hate to ask such a stupid question, but has something "major" changed in
> the IDE code between 2.6.1 and 2.6.2 that would cause it not to probe for
> devices?  I've got 2.6.1 running great.  This morning when I used my 2.6.1
> config file for 2.6.2 (doing a make oldconfig), everything compiles great.
> Unfortunately when I boot 2.6.2, it doesn't find any IDE devices.  With
> 2.6.1, the IDE code would probe and find my ZIP disk, and 2 CDROMs, now
> with 2.6.2 I get nothing.  Loading ide-cd and/or id-floppy don't do
> anything either.  Enclosed is my config file.  I've also tried adding and
> removing different boot params such as:

Major change is that you can compile generic host driver as module now.

>From your .config:

CONFIG_IDE_GENERIC=m
CONFIG_BLK_DEV_PIIX=m

Is this intentional?
Maybe you forgot to load 'piix' module?

--bart

