Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUC1DLS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 22:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUC1DLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 22:11:18 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:1447 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262056AbUC1DLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 22:11:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [PATCH 24/44] Workaround i8042 chips with broken MUX mode
Date: Sat, 27 Mar 2004 22:11:09 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suze.cz>, torvalds@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
References: <20040316182409.54329.qmail@web80508.mail.yahoo.com> <200403271940.39940.dtor_core@ameritech.net> <20040328012507.GA11840@wsdw14.win.tue.nl>
In-Reply-To: <20040328012507.GA11840@wsdw14.win.tue.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403272211.09229.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 March 2004 08:25 pm, Andries Brouwer wrote:
> On Sat, Mar 27, 2004 at 07:40:39PM -0500, Dmitry Torokhov wrote:
> 
> > > The Synaptics multiplexing proposal uses 0xf0, 0x56, 0xa4
> > > to activate and 0xf0, 0x56, 0xa5 to deactivate.
> > > In both cases the replies must be 0xf0, 0x56, version.
> > > 
> > > Thus, I suppose one might get a more robust detection
> > > by checking that both the activation and deactivation
> > > sequences yield the same version.
> > >
> > 
> > Unfortunately in this particular case it looks like something flips
> > 4th bit on some (but not all, like every 3rd) bytes, so it may very
> > well respond with 0xAC to both queries.
> 
> If one flips that bit on 0xa5 the result is 0xad, not 0xac.

Yes, you are right.

> 
> That the bit is set is not strange.
> The standard PS/2 protocol requires bit 3 in the first word of
> every 3-byte packet to be 1.

If it did it in every 3rd byte and not in response to loopback requiest
but to real data stream coming from a device I would agree...

-- 
Dmitry
