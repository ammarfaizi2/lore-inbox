Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264091AbRFSJcw>; Tue, 19 Jun 2001 05:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264096AbRFSJcm>; Tue, 19 Jun 2001 05:32:42 -0400
Received: from [204.94.214.10] ([204.94.214.10]:40045 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S264091AbRFSJcg>; Tue, 19 Jun 2001 05:32:36 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Miles Lane <miles@megapathdsl.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac15 -- Unresolved symbols "gameport_register_port" and "gameport_unregister_port" in char/joystick/[cs461x.o, emu10k1-gp.o, lightning.o, ns558.o, pcigame.o] 
In-Reply-To: Your message of "18 Jun 2001 12:31:28 MST."
             <992892690.11752.0.camel@agate> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 19 Jun 2001 19:31:55 +1000
Message-ID: <18479.992943115@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2001 12:31:28 -0700, 
Miles Lane <miles@megapathdsl.net> wrote:
>I don't know if this is due to symbols not being exported or due
>to some failed dependency structuring in "make menuconfig".
>depmod: *** Unresolved symbols in
>/lib/modules/2.4.5-ac15/kernel/drivers/char/joystick/cs461x.o
>depmod: 	gameport_register_port
>depmod: 	gameport_unregister_port

Works for me with your .config fragment.  It could be a menu order
dependency, save .config, make oldconfig, compare the saved and new
.config.  If they are different then it was a menuconfig order
problem[*], if they are the same then I need your full .config, not
just an extract.

[*] A good reason to use CML2 ;)

