Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUBNJ63 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 04:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUBNJ62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 04:58:28 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:44160 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S261567AbUBNJ61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 04:58:27 -0500
Date: Sat, 14 Feb 2004 10:59:00 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Meelis Roos <mroos@linux.ee>
Subject: Re: Strange atkbd messages with missing keyboard
Message-ID: <20040214095900.GA323@ucw.cz>
References: <Pine.GSO.4.44.0402131509160.18344-100000@math.ut.ee> <200402131327.46543.dtor_core@ameritech.net> <20040213185744.GA1371@ucw.cz> <200402131746.15884.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402131746.15884.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 05:46:15PM -0500, Dmitry Torokhov wrote:

> > > I wonder if changing timeout in atkbd_sendbyte to 400 or 500 ms will
> > > cure the problem.
> > 
> > It probably would, but it also would slow down the detection. I think we
> > can simply ignore bytes with the timeout flag set in the atkbd_interrupt
> > function when we're not expecting an ACK/NAK.
> > 
> 
> The problem with this approach is that if late NAK comes while we are
> actually waiting for result of some other command it will interfere and 
> can cause misdetection.

This only happens with timeout NAKs. And in that case, there is no
device to talk to - and thus nothing can be misdetected.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
