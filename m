Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVCNMTZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVCNMTZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 07:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVCNMTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 07:19:25 -0500
Received: from styx.suse.cz ([82.119.242.94]:16864 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261436AbVCNMTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 07:19:21 -0500
Date: Mon, 14 Mar 2005 13:19:56 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephen Evanchik <evanchsa@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11] IBM TrackPoint support
Message-ID: <20050314121956.GA1985@ucw.cz>
References: <a71293c2050313210230161278@mail.gmail.com> <20050314081949.GA2309@ucw.cz> <a71293c20503140401651ebfe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71293c20503140401651ebfe0@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 07:01:23AM -0500, Stephen Evanchik wrote:
> On Mon, 14 Mar 2005 09:19:49 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > > +/*
> > > + * Mode manipulation
> > > + */
> > > +#define TP_SET_SOFT_TRANS (0x4E) /* Set mode */
> > > +#define TP_CANCEL_SOFT_TRANS (0xB9) /* Cancel mode */
> > > +#define TP_SET_HARD_TRANS (0x45) /* Mode can only be set */
> > 
> > What exactly is transparent mode?
> 
> Transparency mode, when enabled, turns off the TrackPoint controller's
> interpretation of the byte stream going to and coming from the
> external PS/2 port if present.
> 
> Soft transparency mode can be cancelled, while hard transparency mode
> requires a reset of the device and possibly the machine.
 
How much does it interpret the stream in non-transparent mode? Are
commands also passed through in soft transparent mode?

I'm asking because we might want to implement a passthrough port
similarly to what the Synaptics driver does and allow extended protocol
mice to be connected to the external mouse port.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
