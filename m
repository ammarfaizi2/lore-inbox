Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265046AbTFLX24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTFLX24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:28:56 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:4009 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S265046AbTFLX2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:28:55 -0400
Date: Fri, 13 Jun 2003 01:42:40 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
In-Reply-To: <20030613012746.A28341@ucw.cz>
Message-ID: <Pine.LNX.4.40.0306130134470.10788-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jun 2003, Vojtech Pavlik wrote:

> > > The synaptics driver, if it wished to demultiplex a true mouse protocol
> > > behind the pad without an active multiplexing controller, could easily
> > > create a new serio port, to which the psmouse driver would attach,
> > > detect, and drive the mouse. It's a bit crazy, but it should work.

> > hmm, that is clever. But I am afraid it will not work: the master (the

> That's sad. Anyway, we'll have to find a solution for this. Either the
> synaptics driver parsing the communication on the new serio port (which
> isn't as complex as it looks) and detecting the packet length from that,
> or some way the psmouse driver can tell it what packet size it uses.

If the synaptic driver can deduce the protocol by listning to the probing
communication, it might as well just sent it itself.

Peter
--
E-Mail:       pebl@math.ku.dk
Real name:    Peter Berg Larsen
Where:        Department of Computer Science, Copenhagen Uni., Denmark


