Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbTJ0Wrc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 17:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTJ0Wrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 17:47:32 -0500
Received: from kweetal.tue.nl ([131.155.3.6]:5128 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263601AbTJ0Wrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 17:47:31 -0500
Date: Mon, 27 Oct 2003 23:47:28 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andi Kleen <ak@muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>, vojtech@suse.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PS/2 mouse rate setting
Message-ID: <20031027224728.GA10618@win.tue.nl>
References: <20031027140217.GA1065@averell> <Pine.LNX.4.44.0310270830060.1699-100000@home.osdl.org> <20031027183856.GA1461@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027183856.GA1461@averell>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 07:38:56PM +0100, Andi Kleen wrote:
> On Mon, Oct 27, 2003 at 08:32:15AM -0800, Linus Torvalds wrote:

> > I'd suggest we _not_ set the rate by default at all (and let the default
> > thing just happen). And only set the rate if the user _asks_ for it with
> > your setup thing. Mind sending me that kind of patch?
> 
> Here's the new patch with this change.

> -unsigned int psmouse_rate = 60;
> +unsigned int psmouse_rate = 0;

> +__setup("psmouse_rate=", psmouse_rate_setup);

Hmm. I hate this.

Linus, please - don't ask for such things.
Our kernel does not need twelve thousand boot parameters.

Mouse rate is of no importance during boot.
Ergo, there is no reason to have it a boot parameter.

Doing the default thing is good enough, I agree.
And if the user wants something else, userspace should take care.

Andries

