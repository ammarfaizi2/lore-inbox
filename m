Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTFIUP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbTFIUP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:15:28 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30415 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261444AbTFIUPY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:15:24 -0400
Date: Mon, 9 Jun 2003 13:30:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@suse.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New system device API
In-Reply-To: <20030609184233.GA201@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306091323340.11379-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You are currently adding more methods and semantics just to make
> system devices separate from "normal" ones. If you keep two-stage
> (actually three-stage suspend), you'll have system devices similar to
> normal ones, and will have less special cases to care about.

The whole point of doing this is because system devices are not regular 
devices and shouldn't be treated as such. This actually simplifies the 
requirements for representing system devices in the device hierarchy, 
despite adding new functions..

> And keyboard controller with its devices needs to be suspended
> early/resumed late because both operations are likely to need
> interrupts.

So? A keyboard controller is not classified as a system device.


	-pat

