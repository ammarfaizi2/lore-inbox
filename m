Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbUCMHtn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 02:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbUCMHtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 02:49:42 -0500
Received: from prosun.first.gmd.de ([194.95.168.2]:16895 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262416AbUCMHtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 02:49:41 -0500
Subject: Re: 2.6.4 - powerbook 15" - usb oops+backtrace
From: Soeren Sonnenburg <kernel@nn7.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1079137438.1960.47.camel@gaston>
References: <1079097936.1837.102.camel@localhost>
	 <1079137438.1960.47.camel@gaston>
Content-Type: text/plain
Message-Id: <1079164176.3198.1.camel@localhost>
Mime-Version: 1.0
Date: Sat, 13 Mar 2004 08:49:37 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-03-13 at 01:23, Benjamin Herrenschmidt wrote:
> On Sat, 2004-03-13 at 00:25, Soeren Sonnenburg wrote:
> > Hi!
> > 
> > I got this oops when inserting mouse/keyboard (both usb).
> > 
> > usb 1-1: new low speed USB device using address 4
> > input: USB HID v1.00 Mouse [Cypress Sem USB Mouse] on usb-0001:01:18.0-1
> > Oops: kernel access of bad area, sig: 11 [#1]
> > NIP: 5A5A5A58 LR: C026D8B0 SP: ED6B1E10 REGS: ed6b1d60 TRAP: 0401    Not
> 
> NIP is the program counter, something tried to jump into nowhereland,
> find out who by looking at who "owns" C026D8B0 in System.map

this is the area around c026d8b0, so input_accept_process or noone ?!

c026d350 T input_event
c026d7c0 t input_repeat_key
c026d874 T input_accept_process
c026d8b8 T input_grab_device
c026d8dc T input_release_device
c026d8f8 T input_open_device
c026d94c T input_flush_device
c026d990 T input_close_device

Soeren

