Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUBPVAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUBPVAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:00:17 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:33419 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265823AbUBPVAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:00:13 -0500
Date: Mon, 16 Feb 2004 15:58:20 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Michael Buesch <mbuesch@freenet.de>
cc: Simon Gate <simon@noir.se>, <linux-kernel@vger.kernel.org>
Subject: Re: psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization,
 throwing 2 bytes away.
In-Reply-To: <200402142259.34836.mbuesch@freenet.de>
Message-ID: <Pine.GSO.4.33.0402161552520.28488-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Feb 2004, Michael Buesch wrote:
>> psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throwing 2 bytes away.
>>
>> My mouse goes crazy for a few secs and then returns to normal for a while. Is this a 2.6.2 problem or is this is something old?

I've seen this junk for many years.  It's not limited to just 2.6.

In my current environment, it's the KVM screwing with the mouse data...
somehow it starts passing through 3 byte commands when the mouse is in
4 byte mode.  I fixed it by a little trickery to force the mouse to
reset (not a simple task from the ISR :-)  BTW, 250ms is WAY to long to
wait to detect a lose of sync; mice don't pause at all between bytes.)

>here's the fix:
...

And exactly what is that supposed to be fixing?

--Ricky


