Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbTFMHav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 03:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265225AbTFMHav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 03:30:51 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:30920 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265224AbTFMHau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 03:30:50 -0400
Date: Fri, 13 Jun 2003 09:44:35 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: Peter Berg Larsen <pebl@math.ku.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-ID: <20030613094435.B29859@ucw.cz>
References: <20030613012746.A28341@ucw.cz> <Pine.LNX.4.40.0306130134470.10788-100000@shannon.math.ku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0306130134470.10788-100000@shannon.math.ku.dk>; from pebl@math.ku.dk on Fri, Jun 13, 2003 at 01:42:40AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 01:42:40AM +0200, Peter Berg Larsen wrote:

> On Fri, 13 Jun 2003, Vojtech Pavlik wrote:
> 
> > > > The synaptics driver, if it wished to demultiplex a true mouse protocol
> > > > behind the pad without an active multiplexing controller, could easily
> > > > create a new serio port, to which the psmouse driver would attach,
> > > > detect, and drive the mouse. It's a bit crazy, but it should work.
> 
> > > hmm, that is clever. But I am afraid it will not work: the master (the
> 
> > That's sad. Anyway, we'll have to find a solution for this. Either the
> > synaptics driver parsing the communication on the new serio port (which
> > isn't as complex as it looks) and detecting the packet length from that,
> > or some way the psmouse driver can tell it what packet size it uses.
> 
> If the synaptic driver can deduce the protocol by listning to the probing
> communication, it might as well just sent it itself.

Not the protocol. Just the number of bytes per packet. That's quite a
different amount of understanding of the data passed through.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
