Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUBQNo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 08:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUBQNo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 08:44:56 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:34176 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S266157AbUBQNoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 08:44:55 -0500
Date: Tue, 17 Feb 2004 14:44:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Michael Buesch <mbuesch@freenet.de>, Simon Gate <simon@noir.se>,
       linux-kernel@vger.kernel.org
Subject: Re: psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
Message-ID: <20040217134453.GA472@ucw.cz>
References: <200402142259.34836.mbuesch@freenet.de> <Pine.GSO.4.33.0402161552520.28488-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0402161552520.28488-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 03:58:20PM -0500, Ricky Beam wrote:

> On Sat, 14 Feb 2004, Michael Buesch wrote:
> >> psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
> >>
> >> My mouse goes crazy for a few secs and then returns to normal for a while. Is this a 2.6.2 problem or is this is something old?
> 
> I've seen this junk for many years.  It's not limited to just 2.6.
> 
> In my current environment, it's the KVM screwing with the mouse data...
> somehow it starts passing through 3 byte commands when the mouse is in
> 4 byte mode.  I fixed it by a little trickery to force the mouse to
> reset (not a simple task from the ISR :-)  BTW, 250ms is WAY to long to
> wait to detect a lose of sync; mice don't pause at all between bytes.)

Mice don't, but the kernel does, like when it's accessing the harddrive
heavily.

> >here's the fix:
> ...
> 
> And exactly what is that supposed to be fixing?
> 
> --Ricky
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
