Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264312AbUEDLnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbUEDLnS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 07:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUEDLnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 07:43:17 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:21265 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S264312AbUEDLnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 07:43:14 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 4x card in 8x AGP KT600 = locked solid (AGP bug?)
Reply-To: Ian McConnell <ian@emit.demon.co.uk>
References: <871xm1tz1f.fsf@emit.demon.co.uk>
From: Ian McConnell <ian@emit.demon.co.uk>
Date: Tue, 04 May 2004 12:43:12 +0100
In-Reply-To: <871xm1tz1f.fsf@emit.demon.co.uk> (Ian McConnell's message of
 "Mon, 03 May 2004 14:34:20 +0100")
Message-ID: <874qqw8lkf.fsf@emit.demon.co.uk>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian McConnell <kernel@emit.demon.co.uk> writes:

> So two difference implementations of DRI hanging makes me suspect that there
> is a bug with AGP (Also the same video card, kernel and X worked well with
> an older 4xAGP KT133 motherboard)

Looks like I was wrong about it being an AGP bug. I found testgart and 
everything works fine:

# testgart 
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
version: 0.100
bridge id: 0x31891106
agp_mode: 0x1f000a17
aper_base: 0xe8000000
aper_size: 64
pg_total: 112384
pg_system: 112384
pg_used: 0
entry.key : 0
entry.key : 1
Allocated 8 megs of GART memory
MemoryBenchmark: 1173 mb/s
MemoryBenchmark: 1766 mb/s
MemoryBenchmark: 1772 mb/s
Average speed: 1570 mb/s
Testing data integrity (1st pass): passed on first pass.
Testing data integrity (2nd pass): passed on second pass.

