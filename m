Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbUC1BZP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 20:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbUC1BZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 20:25:15 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:61704 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262051AbUC1BZL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 20:25:11 -0500
Date: Sun, 28 Mar 2004 03:25:07 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suze.cz>,
       torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
Message-ID: <20040328012507.GA11840@wsdw14.win.tue.nl>
References: <20040316182409.54329.qmail@web80508.mail.yahoo.com> <20040328002938.GA11657@wsdw14.win.tue.nl> <200403271940.39940.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403271940.39940.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : mailhost.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 07:40:39PM -0500, Dmitry Torokhov wrote:

> > The Synaptics multiplexing proposal uses 0xf0, 0x56, 0xa4
> > to activate and 0xf0, 0x56, 0xa5 to deactivate.
> > In both cases the replies must be 0xf0, 0x56, version.
> > 
> > Thus, I suppose one might get a more robust detection
> > by checking that both the activation and deactivation
> > sequences yield the same version.
> >
> 
> Unfortunately in this particular case it looks like something flips
> 4th bit on some (but not all, like every 3rd) bytes, so it may very
> well respond with 0xAC to both queries.

If one flips that bit on 0xa5 the result is 0xad, not 0xac.

That the bit is set is not strange.
The standard PS/2 protocol requires bit 3 in the first word of
every 3-byte packet to be 1.

Andries
