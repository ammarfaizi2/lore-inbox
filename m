Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266474AbUIOS3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266474AbUIOS3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267223AbUIOS3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:29:15 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:20172 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S266474AbUIOS3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:29:07 -0400
Date: Wed, 15 Sep 2004 11:28:55 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] remove the BKL (Big Kernel Lock), this time for real
Message-ID: <20040915182855.GA11313@taniwha.stupidest.org>
References: <20040915151815.GA30138@elte.hu> <Pine.LNX.4.58.0409150826150.2333@ppc970.osdl.org> <20040915155555.GA11019@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915155555.GA11019@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 05:55:55PM +0200, Ingo Molnar wrote:

> Rare activity that still runs under the BKL (e.g. mounting, or
> ioctls) can introduce many milliseconds of scheduling delays that
> hurt latencies.

Is it not worth looking at the worst offenders (ioctl will be hard I
suspect) and fixing these as an interim step?


  --cw
