Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTFMIpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 04:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbTFMIpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 04:45:06 -0400
Received: from imf.math.ku.dk ([130.225.103.32]:19930 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S265270AbTFMIpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 04:45:02 -0400
Date: Fri, 13 Jun 2003 10:58:47 +0200 (CEST)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: Vojtech Pavlik <vojtech@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
In-Reply-To: <20030613094435.B29859@ucw.cz>
Message-ID: <Pine.LNX.4.40.0306131047540.20231-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 13 Jun 2003, Vojtech Pavlik wrote:

> > > > hmm, that is clever. But I am afraid it will not work: the master (the

> > If the synaptic driver can deduce the protocol by listning to the probing
> > communication, it might as well just sent it itself.
>
> Not the protocol. Just the number of bytes per packet. That's quite a
> different amount of understanding of the data passed through.

Ahh, that would not work either. The description of master/guest was
probably not the best: The protocolbytes from the guest do not even
reach the KBC because the master (touchpad) is ignoring them. So as soon
the guest accepts an protocol more advanced than ps/2 the master must be
told how many bytes is used in the protocol.


Peter




