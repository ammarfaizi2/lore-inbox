Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266098AbTFWSul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 14:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbTFWSul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 14:50:41 -0400
Received: from mailc.telia.com ([194.22.190.4]:51409 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S266098AbTFWSuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 14:50:03 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
References: <m2smqhqk4k.fsf@p4.localdomain> <20030615001905.A27084@ucw.cz>
	<m2he6rv8i6.fsf@telia.com> <20030615142838.A3291@ucw.cz>
	<m2of0zqr4i.fsf@telia.com> <20030615192731.A6972@ucw.cz>
	<m2d6hbgdhw.fsf@telia.com>
	<pan.2003.06.23.16.30.42.431561@dungeon.inka.de>
From: Peter Osterlund <petero2@telia.com>
Date: 23 Jun 2003 21:04:06 +0200
In-Reply-To: <pan.2003.06.23.16.30.42.431561@dungeon.inka.de>
Message-ID: <m2isqwr4yh.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus <aj@dungeon.inka.de> writes:

> I tried that driver with 2.5.73. The synaptics option is gone, so it is
> always on by default? No way to turn it off?

Correct. I don't know if it was an accident or if it was an
intentional decision, but there doesn't seem to be a way to make the
touchpad operate in relative (compatibility) mode any more.

On the other hand, I don't think there will be any reason to use
relative mode once we have X and gpm support for absolute mode, and
when guest devices are supported.

> The touchpad is working ok, but the mouse is moving either slow or too
> fast. I guess there is a way I can configure that?

Yes, use the synclient program to tweak parameters until you find a
setting you like. (I use MinSpeed=0.08 and MaxSpeed=0.10). Then put
them in the XF86Config file. The INSTALL file has an example
InputDevice section that you may want to start from.

> a bigger problem is: X froze once, but I could login via network and
> kill -9 it. No idea why, there is nothing special in the log file.

I've seen X freeze too. I'll debug it, but it will have to wait a week
until I get back from my vacation.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
