Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268751AbUJKKIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbUJKKIm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 06:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268758AbUJKKIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 06:08:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:1740 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268751AbUJKKIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 06:08:40 -0400
Date: Mon, 11 Oct 2004 12:08:40 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041011100840.GB26677@atrey.karlin.mff.cuni.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <1097466354.3539.14.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097466354.3539.14.camel@gaston>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The problem with your fix is that it removes from the drivers the knowledge
> of PM_SUSPEND_DISK (well ,maybe still obtainable via a global, but that's
> really ugly). Also, it causes drivers to default to D3 for suspend-to-disk
> which doesn't make much sense.

Global does not sound *that* bad to me... Actually I want drivers to
default to D3 for suspend-to-disk, because that's the state where DMA
is guaranteed to be off. It might be ugly but its better safe than
sorry situation.
									Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
