Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbUC1RiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbUC1RiE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:38:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23235 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262238AbUC1RgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:36:20 -0500
Date: Sun, 28 Mar 2004 19:35:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328173508.GI24370@suse.de>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40670BD9.9020707@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28 2004, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sat, Mar 27 2004, Jeff Garzik wrote:
> >
> >>I also wouldn't want to lock out any users who wanted to use SATA at 
> >>full speed ;-)
> >
> >
> >And full speed requires 32MB requests?
> 
> 
> Full speed is the SATA driver supporting the hardware maximum.  The 

Come on Jeff, don't be such a slave to the hardware specifications. Just
because it's possible to send down 32MB requests doesn't necessarily
mean it's a super thing to do, nor that it automagically makes 'things
go faster'. The claim is that back-to-back 1MB requests are every bit as
fast as a 32MB request (especially if you have a small queue depth, in
that case there truly should be zero benefit to doing the bigger ones).
The cut-off point is likely even lower than 1MB, I'm just using that
figure as a value that is 'pretty big' yet doesn't incur too large
latencies just because of its size.

-- 
Jens Axboe

