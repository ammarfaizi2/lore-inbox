Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUCSN4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262999AbUCSN4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:56:38 -0500
Received: from styx.suse.cz ([82.208.2.94]:23680 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S263001AbUCSN4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:56:37 -0500
Date: Fri, 19 Mar 2004 14:56:53 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Vojtech Pavlik <vojtech@suze.cz>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
Message-ID: <20040319135653.GA658@ucw.cz>
References: <20040316182409.54329.qmail@web80508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316182409.54329.qmail@web80508.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 10:24:09AM -0800, Dmitry Torokhov wrote:
> Vojtech Pavlik wrote:
> > +	
> > +	/* Workaround for broken chips which seem to
> support MUX, but in reality don't. */
> > +	/* They all report version 12.10 */
> > +	if (mux_version == 0xCA)
> > +		return -1;
> 
> Hi, 
> 
> I think it should be 0xAC (0xA4 with 4th bit flipped)
> as the version reported is 10.12:
> 
> i8042.c: Detected active multiplexing controller, rev
> 10.12.
> 
> From little debug info that I've been sent ThinkPad's
> controllers seem to be flipping 4th bit sometimes, I
> can't quite pinpoint the exact sequence.

Thanks, fixed.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
