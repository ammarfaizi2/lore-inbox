Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUGSAHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUGSAHo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 20:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbUGSAHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 20:07:44 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:7085 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S264609AbUGSAHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 20:07:43 -0400
Date: Sun, 18 Jul 2004 17:07:38 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ed Sweetman <safemode@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: audio cd writing causes massive swap and crash
Message-ID: <20040719000738.GA8261@taniwha.stupidest.org>
References: <40F9854D.2000408@comcast.net> <20040717123443.18065893.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040717123443.18065893.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 17, 2004 at 12:34:43PM -0700, Andrew Morton wrote:

> Ed Sweetman <safemode@comcast.net> wrote:

> > Both with 2.6.7-rc3 and 2.6.8-rc1-mm1 I get the same behavior when
> > writing an audio cd on my plextor px-712a.  DMA is enabled and
> > normal data cds write as expected, but audio cds will cause (at
> > any speed) the box to start using insane amounts of swap (>150MB)
> > and eventually cause the box to crash before finishing the cd.

There is a memory leak somewhere when writing CDs, I've seen this
myself.  Basically for me all low-memory is leaked and with only
highmem left things go bad.

> What is the full cdrecord command line?

doesn't matter for me

> Were earlier kernels OK?

2.4.x is OK for me,  it's been this way in 2.6.x for a very long time,
I keep forgetting to poke about and have a look why.


  --cw
