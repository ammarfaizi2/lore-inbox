Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270899AbUJVE0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270899AbUJVE0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 00:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270851AbUJVEYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 00:24:09 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:16247 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S270930AbUJVEUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 00:20:35 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
X-Message-Flag: Warning: May contain useful information
References: <200410211910.i9LJAKjf029014@hera.kernel.org>
	<20041021203110.GA1532@smtp.west.cox.net>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 21 Oct 2004 21:20:26 -0700
In-Reply-To: <20041021203110.GA1532@smtp.west.cox.net> (Tom Rini's message
 of "Thu, 21 Oct 2004 13:31:10 -0700")
Message-ID: <52sm87gz91.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH] ppc: fix build with O=$(output_dir)
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Oct 2004 04:20:31.0592 (UTC) FILETIME=[77F5E680:01C4B7EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Tom> Can we back this out please?  As I noted on lkml once I saw
    Tom> this, it still doesn't fix the problem of overwriting files
    Tom> in lib/zlib_inflate/ if ZLIB_INFLATE!=n, and adding explicit
    Tom> rules for lib/zlib_inflate/foo.c
    -> ./foo.o looks quite bad (it's 2 calls if we want checker to get
    Tom> invoked, one if we skip doing that).  At the end of the
    Tom> thread, both Roland and I were hoping Sam knew of a clever
    Tom> solution to this.

I can't really object to backing this out, but I'll just point out
that without this patch, in the situations where mainline builds at
all, it still overwrites files in lib/zlib_inflate/.  (And builds with
O=xxx don't work at all)

It might make more sense to leave this patch in for now and beg Sam
for a better fix in the future.

Thanks,
  Roland
