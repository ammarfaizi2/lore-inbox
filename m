Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbTFQTtN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTFQTtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:49:13 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:34322 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264912AbTFQTtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:49:11 -0400
Date: Tue, 17 Jun 2003 21:03:05 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Ian Molton <spyro@f2s.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: FRAMEBUFFER (and console)
In-Reply-To: <20030617015255.3016cb99.spyro@f2s.com>
Message-ID: <Pine.LNX.4.44.0306172059510.21214-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My framebuffer (and therefore system console, by definition) come up
> rather late.
> 
> It seems the console doesnt care to check for drivers comming up after a
> certain time, and thus I get no output despite the driver working.
> 
> I'd like to do something like console_rescan_my_damn_device() if
> possible :-)
> 
> My only option right now appears to be to set up a dummy framebuffer
> prior to real one starting up.

The reason for this is because the framebuffers most often depend on the 
bus being set up. Usually this happening later in the boot process. What 
are trying to do? Retrieve the earlier printk messages. Do you have 
DUMMY_CONSOLE set to Y. I believe the data is transfered from dummycon to 
fbcon after fbcon is initialized. If you having problems with that try 
increasing the size of dummycon's "screen". See dummycon.c for more 
details.


