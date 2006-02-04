Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946321AbWBDHFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946321AbWBDHFV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 02:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946322AbWBDHFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 02:05:21 -0500
Received: from styx.suse.cz ([82.119.242.94]:29576 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1946321AbWBDHFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 02:05:20 -0500
Date: Sat, 4 Feb 2006 08:05:20 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shaun Jackman <sjackman@gmail.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] liyitec: Liyitec PS/2 touchscreen driver
Message-ID: <20060204070519.GA5866@suse.cz>
References: <7f45d9390602021502q325752d7oe635569cde7ce2c7@mail.gmail.com> <d120d5000602021512x42be2006h31e63cb6d78ac1b3@mail.gmail.com> <7f45d9390602031639k3c5ae010gbd52a8fdd8bb863b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f45d9390602031639k3c5ae010gbd52a8fdd8bb863b@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 05:39:30PM -0700, Shaun Jackman wrote:

> So, finally, assuming there is no way to detect the touch panel's
> presence, should the driver still be rolled into psmouse? If so, how
> should the user specify she wishes to use the liyitec driver, and
> which serio (PS/2) port the liyitec touch screen is on?
> 
> My current patch implements the Liyitec driver as a serio driver that
> grabs every available PS/2 port. Quite unfriendly, but works in the
> typical case where the keyboard driver grabs the first port, and the
> Liyitec driver grabs the psaux port.

I hope the driver at least checks that the port is untranslated
(SERIO_I8042, not SERIO_I8042_XL), and that the device behaves as a
mouse.

Btw, I assume the packet format is also indistinguishable from a
standard PS/2 mouse?

If it were integrated into psmouse, it probably need to be enabled by a
module parameter.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
