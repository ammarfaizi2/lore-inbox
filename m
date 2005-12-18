Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965288AbVLRWHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965288AbVLRWHT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbVLRWHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:07:19 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:45996 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S965288AbVLRWHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:07:17 -0500
Subject: Re: USB rejecting sleep
From: Marcel Holtmann <marcel@holtmann.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1134939687.6102.99.camel@gaston>
References: <1134937642.6102.85.camel@gaston>
	 <200512181258.47030.david-b@pacbell.net>  <1134939687.6102.99.camel@gaston>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 23:07:01 +0100
Message-Id: <1134943621.6881.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

> > > What exactly changed in the recent USB stacks that is causing it to
> > > abort system suspend much more often ? I'm getting lots of user reports
> > > with 2.6.15-rc5 saying that they can't put their internal laptops to
> > > sleep, apparently because a driver doesn't have a suspend method
> > > (internal bluetooth in this case).
> > 
> > Which I hope _did_ generate a bug report to the maintainer of that
> > bluetooth code.  :)
> 
> I'm working on it :)

did I mention that this driver really needs a rewrite :(

It is full of ugly hacks around the URB structure. The use of the URBs
for the bulk and isoc endpoints is not really how it should look like.
It will consume USB bandwidth even if there are not active data or audio
connections from this device. I am still curious that it is still
working (except for suspend).

Regards

Marcel


