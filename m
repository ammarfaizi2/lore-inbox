Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUARRSQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 12:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUARRSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 12:18:16 -0500
Received: from hera.cwi.nl ([192.16.191.8]:12991 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262052AbUARRSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 12:18:11 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 18 Jan 2004 18:18:05 +0100 (MET)
Message-Id: <UTC200401181718.i0IHI5F26519.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, der.eremit@email.de
Subject: Re: Making MO drive work with ide-cd
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Pascal Schmidt <der.eremit@email.de>

    >> There is a patch by me with some rework by Jens Axboe in -mm that
    >> corrects this situation. It hasn't seen much testing, though.

    > OK, will find that and try later.

Hmm. Looked at it. But it cannot help. All it does is move
cdrom_read_capacity().

But ide-cd remains fundamentally broken for disks.
It sends cdrom commands, and they fail, and it does not do
disk things that are needed. First of all, we need partitions,
but ide-cd.c puts g->minors = 1.

Don't know whether Jens really wants to bend ide-cd.c until
it also handles disks, but it smells like a hack.

Andries
