Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUC1SOi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUC1SOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:14:37 -0500
Received: from holomorphy.com ([207.189.100.168]:44694 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262311AbUC1SOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:14:34 -0500
Date: Sun, 28 Mar 2004 10:12:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328181223.GA791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406612AA.1090406@yahoo.com.au> <4066156F.1000805@pobox.com> <20040328141014.GE24370@suse.de> <40670BD9.9020707@pobox.com> <20040328173508.GI24370@suse.de> <40670FDB.6080409@pobox.com> <20040328175436.GL24370@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328175436.GL24370@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 07:54:36PM +0200, Jens Axboe wrote:
> Sorry, but I cannot disagree more. You think an artificial limit at the
> block layer is better than one imposed at the driver end, which actually
> has a lot more of an understanding of what hardware it is driving? This
> makes zero sense to me. Take floppy.c for instance, I really don't want
> 1MB requests there, since that would take a minute to complete. And I
> might not want 1MB requests on my Super-ZXY storage, because that beast
> completes io easily at an iorate of 200MB/sec.
> So you want to put this _policy_ in the block layer, instead of in the
> driver. That's an even worse decision if your reasoning is policy. The
> only such limits I would want to put in, are those of the bio where
> simply is best to keep that small and contained within a single page to
> avoid higher order allocations to do io. Limits based on general sound
> principles, not something that caters to some particular piece of
> hardware. I absolutely refuse to put a global block layer 'optimal io
> size' restriction in, since that is the ugliest of policies and without
> having _any_ knowledge of what the hardware can do.

How about per-device policies and driver hints wrt. optimal io?


-- wli
