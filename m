Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTFZUbR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 16:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbTFZUbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 16:31:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:11226 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262524AbTFZUbF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 16:31:05 -0400
Date: Thu, 26 Jun 2003 22:45:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: =?iso-8859-2?Q?Terje_F=E5berg?= <terje_fb@yahoo.no>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.73 - keyboard failure, repost no. 3
Message-ID: <20030626224517.C5633@ucw.cz>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com> <20030623203224.1180.qmail@web12902.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030623203224.1180.qmail@web12902.mail.yahoo.com>; from terje_fb@yahoo.no on Mon, Jun 23, 2003 at 10:32:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 10:32:24PM +0200, Terje Fåberg wrote:
> 
> Hi all, 
> 
> (and yes, I read the post-halloween docs!)
> 
> Just a note on the side: 2.5.73 fails to make use of
> the keyboard on my Mitac 8375 Laptop. It correctly
> identifies the controller AND the keyboard, but no
> keypresses are recognized.
> 
> What can I do to track this down?

	#define DEBUG

in

	drivers/input/serio/i8042.c

then recompile and send me the output of that.

> 
> This problem exists at least since 2.5.67.  Linux-2.4 
> runs perfectly.
> 
> Please see the .config and kernel output
> ...
> pc110pad: I/O area 0x15e0-0x15e4 un use.
> i8042.c: Detected active multiplexing controller, rev
> 1.1
> serio: i8042 AUX0 port at 0x60,0x64 irq 12
> serio: i8042 AUX1 port at 0x60,0x64 irq 12
> Synaptics Touchpad, model 1
>   Firware: 5.1
>   180 degree mounted touchpad
>   Sensor: 15
>   new absolute packet format
>   Touchpad has extended capability bits
>   -> four buttons
>   -> multifinger detection
>   -> palm detection
>  input: Synaptics Synaptics Touchpad on isa0060/serio3
> serio: i8042 AUX3 port at 0x60,0x64 irq 12
> serio: i8042 AUX4 port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa006 0/serio0
> serio: i8042 KBD port at 0x60,0x64 irq1
> ...
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
