Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268742AbUILSCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268742AbUILSCr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268756AbUILSCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:02:46 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:18845 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268742AbUILSCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:02:40 -0400
Date: Sun, 12 Sep 2004 11:02:29 -0700
From: Chris Wedgwood <cw@f00f.org>
To: William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912180229.GA7157@taniwha.stupidest.org>
References: <20040912085609.GK32755@krispykreme> <20040912093605.GJ2660@holomorphy.com> <20040912095805.GL2660@holomorphy.com> <20040912101350.GA13164@elte.hu> <20040912104314.GN2660@holomorphy.com> <20040912104524.GO2660@holomorphy.com> <20040912110810.GQ2660@holomorphy.com> <20040912112026.GA16678@elte.hu> <20040912171319.GR2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912171319.GR2660@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 10:13:19AM -0700, William Lee Irwin III wrote:

> I presumed it was merely cosmetic, so daemons around system startup
> will get low pid numbers recognizable by sysadmins. Maybe filtering
> process listings for pids < 300 is/was used to find daemons that may
> have crashed? I'm not particularly attached to the feature, and have
> never used it myself, but merely noticed its implementation was off.

I always assumed it was an optimization when looking for a new PID
after a wrap by trying to skip over the kernel threads.  Arguably 300
is way too small for larger systems (which might have several thousand
kernel threads) and should probably be sized on boot (or when starting
userspace) if anyone really cares.
