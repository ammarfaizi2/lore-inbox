Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbUCVXNA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUCVXNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:13:00 -0500
Received: from holomorphy.com ([207.189.100.168]:402 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261468AbUCVXM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:12:57 -0500
Date: Mon, 22 Mar 2004 15:12:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] broken bitmap_parse for ncpus > 32
Message-ID: <20040322231246.GQ2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joe Korty <joe.korty@ccur.com>, Andrew Morton <akpm@osdl.org>,
	Paul Jackson <pj@sgi.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040322202118.GA27281@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322202118.GA27281@tsunami.ccur.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 03:21:18PM -0500, Joe Korty wrote:
> Andrew,
>  This patch replaces the call to bitmap_shift_right() in bitmap_parse()
> with bitmap_shift_left().
> This mental confusion between right and left did not show up in my
> (userland) testing, as I foolishly wrote my own bitmap_shift routines
> rather than drag over the kernel versions.  And it did not show up in my
> kernel testing because no shift routine is called when NR_CPUS <= 32.
> I tested this in userland with the kernel's versions of bitmap_shift_*
> and compiled a kernel and spot checked it on a 2-cpu system.
> I also prepended comments to the bitmap_shift_* functions defining what
> 'left' and 'right' means. This is under the theory that if I and all the
> reviewers were bamboozled, others in the future occasionally might be too.

Bugfixes are always good. Maybe the kerneldoc stuff would be a good idea
for these functions, and the rest of the non-static functions ppl might
be expected to call.


-- wli
