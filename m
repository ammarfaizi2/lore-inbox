Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbUBPWO2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbUBPWO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:14:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:3029 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265921AbUBPWNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:13:48 -0500
Date: Mon, 16 Feb 2004 14:13:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: David Eger <eger@theboonies.us>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-rc3 radeonfb: Problems with new (and old) driver
In-Reply-To: <1076968236.3648.42.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402161410430.30742@home.osdl.org>
References: <Pine.LNX.4.50L0.0402160411260.2959-100000@rosencrantz.theboonies.us>
  <1076904084.12300.189.camel@gaston>  <Pine.LNX.4.58.0402160947080.30742@home.osdl.org>
 <1076968236.3648.42.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> Do we want to pay the cost (in time) of a full mode set + engine reset
> on each unblank ? I could limit myself to restoring the accel engine,
> that faster, but with X also not always restoring the console mode
> properly, I'd have preferred re-setting the whole mode... 

Well, on blanking, we do actually already pass in a parameter that says
"this is not a full blank, it's just a move to graphics mode". It would
make 100% sense to add the _same_ parameter to the unblank code.

That would just make the code more logical, and it should fix your 
concerns, no?

		Linus
