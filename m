Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbULaLgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbULaLgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 06:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbULaLgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 06:36:14 -0500
Received: from ozlabs.org ([203.10.76.45]:36042 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261860AbULaLgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 06:36:13 -0500
Subject: Re: Current saa7134 driver breaks KNC One Tv-Station DVR (card=24)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Johannes Stezenbach <js@linuxtv.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <20041231020814.GA15220@linuxtv.org>
References: <20041231020814.GA15220@linuxtv.org>
Content-Type: text/plain
Date: Fri, 31 Dec 2004 19:29:47 +1100
Message-Id: <1104481787.2791.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-31 at 03:08 +0100, Johannes Stezenbach wrote:
> I've reported this before:
> http://lkml.org/lkml/2004/11/17/275
> 
> The patch that Rusty posted doesn't seem to have it made into
> module-init-tools-3.1. Bummer :-(

Because it was a dumb idea, as your reply showed.  You can't load any
dependent modules because this module is not initialized yet (what if
you loaded a module that depended on you, then failed your
initialization?).  Gerd has the real fix, IIRC.

Rusty.

A bad analogy is like a leaky screwdriver -- Richard Braakman

