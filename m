Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265799AbUHWPyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265799AbUHWPyS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUHWPxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:53:48 -0400
Received: from the-village.bc.nu ([81.2.110.252]:25233 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265799AbUHWPwc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:52:32 -0400
Subject: Re: serialize access to ide device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408231702.54426.bzolnier@elka.pw.edu.pl>
References: <20040802131150.GR10496@suse.de>
	 <200408211913.47982.bzolnier@elka.pw.edu.pl>
	 <20040823121540.GN2301@suse.de>
	 <200408231702.54426.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093272604.29740.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 15:50:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-23 at 16:02, Bartlomiej Zolnierkiewicz wrote:
> No, REQ_SPECIAL-like approach would serialize per ide_hwgroup_t and 
> ide_hwgroup_t may serialize more then one ide_hwif_t.  See ide-probe.c.

This is probably appropriately paranoid behaviour anyway. 
