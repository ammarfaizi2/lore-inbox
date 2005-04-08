Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262623AbVDHAEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVDHAEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVDHAEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:04:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:46303 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262623AbVDHAET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:04:19 -0400
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL
	accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Dave Airlie <airlied@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <jemzsa6sxg.fsf@sykes.suse.de>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	 <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	 <1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	 <21d7e9970504071422349426eb@mail.gmail.com>
	 <1112914795.9568.320.camel@gaston>  <jemzsa6sxg.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 10:03:05 +1000
Message-Id: <1112918586.9567.343.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 01:58 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Yes, that's very extreme, I suspect somebody is banging on set_par or
> > something like that.
> 
> fb_setcolreg is it.

Ahhh... interesting. I'll see if I can find a way to work around that
one. Best would be to "cache" the current PLL register index in fact,
but I'm afraid that may not work terribly well with userland apps
hacking it ...

Ben.


