Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUCWCI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 21:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUCWCIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 21:08:55 -0500
Received: from holomorphy.com ([207.189.100.168]:42642 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261914AbUCWCIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 21:08:54 -0500
Date: Mon, 22 Mar 2004 18:08:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: joe.korty@ccur.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] broken bitmap_parse for ncpus > 32
Message-ID: <20040323020840.GT2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, joe.korty@ccur.com, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040322202118.GA27281@tsunami.ccur.com> <20040322231246.GQ2045@holomorphy.com> <20040322161931.1c63ddfd.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322161931.1c63ddfd.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 04:19:31PM -0800, Paul Jackson wrote:
> Not quite sure what Bill is converying here with the qualifier 'non-static'.
> My inclinations lay more toward looking for improvements, explored in
> other messages on a concurrent thread "[PATCH] Introduce nodemask_t
> ADT", to the cpumask API, to be followed by a kerneldoc, rather than
> trying very hard to document the current API much more.

non-static == exported for people to use, declared in a header, and
without the "static" qualifier to the function. Basically, things added
to the kernel API. As this is the low-level bitmap stuff, I believe it
should be relatively unchanged across whatever API changes you may have
in store for higher-level API's e.g. cpumasks. This is the bitmap
library code we're talking about, isn't it? At least it's what I'm
talking about.


-- wli
