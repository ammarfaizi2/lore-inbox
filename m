Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268209AbUHKUO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268209AbUHKUO1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUHKUO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 16:14:26 -0400
Received: from mail1.kontent.de ([81.88.34.36]:28552 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268209AbUHKUOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 16:14:25 -0400
Date: Wed, 11 Aug 2004 22:14:24 +0200
From: Sascha Wilde <wilde@sha-bang.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, "David N. Welton" <davidw@eidetix.com>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040811201424.GB864@kenny.sha-bang.local>
References: <4107E788.8030903@eidetix.com> <41122C82.3020304@eidetix.com> <200408110131.14114.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408110131.14114.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 01:31:13AM -0500, Dmitry Torokhov wrote:
> On Thursday 05 August 2004 07:48 am, David N. Welton wrote:
> > By putting a series of 'crashme/reboot' calls into the kernel, I 
> > narrowed a possibl cause of it down to this bit of code in 
> > drivers/input/serio.c:753
[...]
> Could you please try the patch below? I am interested in tests both
> with and without keyboard/mouse. The main idea is to leave ports
> that have been disabled by BIOS alone... The patch compiles but
> otherwise untested. Against 2.6.7.

Sorry, but the patch does not work for me.  The resulting kernel
reboots, but it _disables_ (or fails to enable?) the PS/2 keyboard.

I don't know if it is of any interest, but I'm using grub to load
linux (and in the grub boot shell the keyboard works).

> BTW, do you both have the same motherboard/chipset? Maybe a dmi
> entry is in order...

No.  I'm using a MSI Mainboard with AMD (Viper) chipset.

cheers
sascha
-- 
Sascha Wilde : "GUIs normally make it simple to accomplish simple 
             : actions and impossible to accomplish complex actions."
             : (Doug Gwyn - 22/Jun/91 in comp.unix.wizards)
