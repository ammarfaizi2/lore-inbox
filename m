Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTGGSVB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 14:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264248AbTGGSVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 14:21:00 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:59076 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S264226AbTGGSUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 14:20:53 -0400
Date: Mon, 7 Jul 2003 20:35:22 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Synaptics: support for pass-through port (stick)
In-Reply-To: <200307071234.02595.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.40.0307072020380.3501-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jul 2003, Dmitry Torokhov wrote:

> > > +	if (child && child->type >= PSMOUSE_GENPS) {
> > Not type > PSMOUSE_GENPS ?

> We have this code in psmouse-base.c ...
  ...
> ..or am I misreading it?

No, you are right. I misread it as generic ps2 protocol.

A complete different problem that might be a problem is that even though
the master(pad) says it has passthough capabilities, there might not be
any guest attached. The bit only tells that it is capable of handling one.
I asked synaptics about this some time ago and they replyed that the only
way to find out is to send a byte and look for a returnbyte or a timeout.


