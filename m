Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTIDWgI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTIDWgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:36:07 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:37650 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262168AbTIDWgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:36:00 -0400
Date: Fri, 5 Sep 2003 00:34:36 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jamie Lokier <jamie@shareable.org>
Cc: Chris Heath <chris@heathens.co.nz>, aebr@win.tue.nl,
       linux-kernel@vger.kernel.org, vojtech@ucw.cz,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: keyboard - was: Re: Linux 2.6.0-test4
Message-ID: <20030905003436.A3105@pclin040.win.tue.nl>
References: <20030903235647.C765.CHRIS@heathens.co.nz> <20030904204816.GD31590@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904204816.GD31590@mail.jlokier.co.uk>; from jamie@shareable.org on Thu, Sep 04, 2003 at 09:48:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 09:48:16PM +0100, Jamie Lokier wrote:

> Why so many complicated assumptions?  Just maintain a bitmap if key
> up/down states (initialised to up), and if you receive a release event
> when the key is in the up state, ignore the event.

Ha! We maintain two such bitmaps. And they get out of sync too.

You talk too easily. "If you receive a release event".
But one does not receive release events, one receives bytes.
The interpretation of those bytes belongs to the keyboard driver.

But i8042.c needs to know whether scancodes are releases
in order to do its massaging of the scancodes before giving
them to the keyboard driver.

I regard i8042.c as fundamentally broken.
On the other hand, it almost works.

Andries

