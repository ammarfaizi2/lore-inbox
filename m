Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUFCHkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUFCHkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 03:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261648AbUFCHkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 03:40:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:22697 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261606AbUFCHk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 03:40:26 -0400
Date: Thu, 3 Jun 2004 00:39:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, vojtech@suse.cz
Subject: Re: [RFC] Changing SysRq - show registers handling
Message-Id: <20040603003945.3f2ceaf5.akpm@osdl.org>
In-Reply-To: <200406030227.22178.dtor_core@ameritech.net>
References: <200406030134.04121.dtor_core@ameritech.net>
	<200406030208.19612.dtor_core@ameritech.net>
	<20040603001804.750b7fa5.akpm@osdl.org>
	<200406030227.22178.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> > Well bear in mind that we can then rip all the pt_regs passing out from
> > everywhere, so as long as you edit every IRQ handler in the kernel it's a
> > net win ;)
> 
> Will you let me? :) USB and serio will at least not mess anyone else...

There are only 1300 of them.  Could do it in three hours.  Don't tempt me ;)

> > 
> > I _think_ it'll work - as long as all architectures go through a common
> > dispatch function like do_IRQ(), which surely they do.  The above code
> > could be an arch-neutral inline actually.
> > 
> > I'm not sure what's best really.  But something this general is more
> > attractive than something which is purely for sysrs-T.
> > 
> 
> I don't like the requirement of SysRq request processing being in hard
> interrupt handler - that excludes uinput-generated events and precludes
> moving keyboard handling to a tasklet for example.

Ho hum.  May as well run with your original idea I guess.
