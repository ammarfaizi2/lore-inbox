Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTDXAJY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 20:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTDXAJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 20:09:24 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:64728 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S264312AbTDXAJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 20:09:23 -0400
Date: Thu, 24 Apr 2003 12:16:48 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Fix SWSUSP & !SWAP
In-reply-to: <20030424001733.GB678@zip.com.au>
To: CaT <cat@zip.com.au>
Cc: Andrew Morton <akpm@digeo.com>, Pavel Machek <pavel@ucw.cz>,
       mbligh@aracnet.com, gigerstyle@gmx.ch, geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1051143408.4305.15.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1051136725.4439.5.camel@laptop-linux> <1584040000.1051140524@flay>
 <20030423235820.GB32577@atrey.karlin.mff.cuni.cz>
 <20030423170759.2b4e6294.akpm@digeo.com> <20030424001733.GB678@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 12:17, CaT wrote:
> I'm curious. What does a swapfile solve that a swapdev does not? Either
> way you need to prealloc the case (either have a chunky file in a
> partition or a partition set aside) or you need to keep enough room
> avail to fit the file when it's needed.

Nothing but further bloat in swsusp :> With a swapfile, we need to know
the location of the file (and be able to find it again when it changes,
and know how to find the next block in the file system - it might be
fragmented). The simplest solution is to keep using the current method
and create a separate swap partition if you really feel you need to,
only turning it on before swap and turning if off afterwards. As Pavel
said, code could be added to get swsusp to do it itself.

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

