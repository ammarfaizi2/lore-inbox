Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbTITWSm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 18:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbTITWSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 18:18:42 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:56589 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261976AbTITWSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 18:18:40 -0400
Date: Sun, 21 Sep 2003 00:18:38 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Rob Landley <rob@landley.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Keyboard oddness.
Message-ID: <20030921001838.A3619@pclin040.win.tue.nl>
References: <200309201633.22414.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309201633.22414.rob@landley.net>; from rob@landley.net on Sat, Sep 20, 2003 at 04:33:22PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 20, 2003 at 04:33:22PM -0400, Rob Landley wrote:
> I've mentioned my keyboard repeat problems before.  I grepped through the logs 
> and found a whole bunch of these type messages:
> 
> Aug 17 05:28:48 atkbd.c: Unknown key (set 2, scancode 0x1d0, 
> on isa0060/serio0) pressed.
> Aug 19 09:06:51 atkbd.c: Unknown key (set 2, scancode 0x8e, 
> on isa0060/serio0) pressed.
...

These are key releases for keys i8042.c didnt know were down.
If otherwise your keyboard functions well, this is harmless.

> Sep  2 13:37:52 atkbd.c: Unknown key (set 0, scancode 0xfc, 
> on isa0060/serio1) pressed.
> Sep  2 13:37:52 atkbd.c: Unknown key (set 0, scancode 0xfc, 
> on isa0060/serio1) pressed.

I suppose these are error codes from your mouse.
If so, it is a bug that they ever went to atkbd.c.

Andries

