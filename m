Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265167AbTLZKed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 05:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbTLZKec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 05:34:32 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:34978 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265167AbTLZKeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 05:34:31 -0500
Date: Fri, 26 Dec 2003 11:34:27 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: joshk@triplehelix.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
Subject: Re: Can't eject a previously mounted CD?
Message-ID: <20031226103427.GB11127@ucw.cz>
References: <20031226081535.GB12871@triplehelix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226081535.GB12871@triplehelix.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 12:15:35AM -0800, Joshua Kwan wrote:

> I suspect this problem has something to do with my nForce2 motherboard.
> When I mount a CD, unmount it, and try to eject it from my drive, the
> drive flashes the red 'busy / locked' light and refuses to let me eject
> it. I'm using the AMD / nVidia IDE kernel support and the obvious
> conclusion is that it's failing to release the device or something. Is
> this true?

No. :) There isn't anything in that driver that'd be called upon mount
or unmount, it just sets the timings on boottime or when hdparm is
called.

> I suspect the fix would be a one liner.

If you're using SUSE 9.0 ...

	kill suseplugger

... perhaps?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
