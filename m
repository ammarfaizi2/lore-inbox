Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTEWA4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 20:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263566AbTEWA4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 20:56:07 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:23971 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S263552AbTEWA4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 20:56:04 -0400
Subject: Re: irtty_sir cannot be unloaded
From: Stian Jordet <liste@jordet.nu>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030522233609.GA11706@bougret.hpl.hp.com>
References: <20030522233609.GA11706@bougret.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1053652200.709.6.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 23 May 2003 03:10:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 23.05.2003 kl. 01.36 skrev Jean Tourrilhes: 
> Stian Jordet wrote :
> > 
> > Module irtty_sir cannot be unloaded due to unsafe usage in
> > include/linux/module.h:456
> > 
> > I get this message when trying to use irda with 2.5.x. I know it has
> > been there for a long time, but since nothing happens
> 
> 	This is fixed in the patches I've send to Jeff :
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105286597418927&w=2
> 	Just be patient ;-)

Well, this got rid of the warning :) But actually when I stop irattach
(using Debian's init-script (/etc/init.d/irda stop)) my computer
freezes. This works (of course) fine with 2.4.21-rc2. I thought the
problem was the module unloading, but it seems to be something with
irattach instead. Sorry about that.

> 	I guess that if it's the only complain, this means that the
> rest of the IrDA stack works for you in 2.5.X. At least, I'm not the
> only one testing it...

It works, but I get lots of weird/ugly/different messages. This is with
a SonyEricsson P800. Except for those annoying messages in my logs, it
works perfect :-)

irlap_change_speed(), setting speed to 9600
sirdev_open - done, speed = 0
sirdev_schedule_request - state=0x0700 / param=9600
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 115200
sirdev_schedule_request - state=0x0700 / param=115200
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 9600
sirdev_schedule_request - state=0x0700 / param=9600
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 115200
sirdev_schedule_request - state=0x0700 / param=115200
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 9600
sirdev_schedule_request - state=0x0700 / param=9600
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 115200
sirdev_schedule_request - state=0x0700 / param=115200
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 9600
sirdev_schedule_request - state=0x0700 / param=9600
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 115200
sirdev_schedule_request - state=0x0700 / param=115200
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 9600
sirdev_schedule_request - state=0x0700 / param=9600
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 115200
sirdev_schedule_request - state=0x0700 / param=115200
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 9600
sirdev_schedule_request - state=0x0700 / param=9600
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 115200
sirdev_schedule_request - state=0x0700 / param=115200
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 9600
sirdev_schedule_request - state=0x0700 / param=9600
sirdev_schedule_request - down
irda_config_fsm - up
Module ircomm_tty cannot be unloaded due to unsafe usage in
include/linux/module.h:456
ircomm_tty_attach_cable()
ircomm_tty_ias_register()
ircomm_tty_close()
ircomm_tty_close(), open count > 0
irlap_change_speed(), setting speed to 115200
sirdev_schedule_request - state=0x0700 / param=115200
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 9600
sirdev_schedule_request - state=0x0700 / param=9600
sirdev_schedule_request - down
irda_config_fsm - up
irlap_change_speed(), setting speed to 115200
sirdev_schedule_request - state=0x0700 / param=115200
sirdev_schedule_request - down
irda_config_fsm - up
ircomm_param_xon_xoff(), XON/XOFF = 0x11,0x13
ircomm_param_enq_ack(), ENQ/ACK = 0x00,0x00
ircomm_tty_check_modem_status()

I see I have gotten a ircomm_tty can't be unloaded as well. Hmm. Well,
as I said, it works perfect, except for stopping irattach.

Thanks.

Best regards,
Stian

