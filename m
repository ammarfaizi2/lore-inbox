Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270967AbTHKMFL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272511AbTHKMFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:05:11 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:46501 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S270967AbTHKMFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:05:07 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 11 Aug 2003 14:15:46 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Michael Buesch <fsdeveloper@yahoo.de>
Cc: video4linux-list@redhat.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.6-test3] bttv driver doesn't run
Message-ID: <20030811121546.GA8998@bytesex.org>
References: <200308092104.48878.fsdeveloper@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308092104.48878.fsdeveloper@yahoo.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When trying to run the tv-application "tvtime", the kernel
> throws some more messages. tvtime worked fine for a few
> seconds (video and audio worked), but then it froze and
> was non-workable from then on.

Does reloading the driver help?

> Aug  9 20:49:08 lfs kernel: bttv0: timeout: risc=0f7ae874, bits: VSYNC HSYNC OFLOW RISCI
> Aug  9 20:49:08 lfs kernel: bttv0: reset, reinitialize

Yea, the reinitialize function doesn't re-enable the interrupts.
Try latest patches from bytesex.org/patches/ which have this fixed, that
should improve error recovery ...

  Gerd

