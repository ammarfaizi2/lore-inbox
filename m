Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUEKG00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUEKG00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUEKG0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:26:23 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:36472 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262370AbUEKGZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:25:10 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 0/9] New set of input patches
Date: Tue, 11 May 2004 01:24:14 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200405110124.14948.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I have some more input patches. Nothing too intresting, most of the important
stuff has been posted on LKML before. Here they are:

01-serio-whitespace.patch:
	trailing whitespace fixes in drivers/input/serio

02-kbd98io-interrupt.patch:
	kbd98io_interrupt should return irqreturn_t

03-kdb98-interrupt.patch:
	kbd98_interrupt should return irqreturn_t

04-h3600-fixes.patch:
	various fixes for H3600 touchscreen driver
         - h3600ts_interrupt, npower_button_handler and action_button_handler
           should return irqreturn_t
         - fix missing argument in h3600ts_process_packet call
         - add MODULE_AUTHOR, MODULE_DESCRIPTION and MODULE_LICENSE
         - small formatting changes
	It still does not compile because of bad PM_ constants though

05-twidjoy-fixes.patch:
         - twidjoy_interrupt should return irqreturn_t
         - add MODULE_DESCRIPTION and MODULE_LICENSE

06-keyboard-whitespace.patch:
	trailing whitespace fixes in drivers/input/keyboard

07-power-license.patch:
	power - add MODULE_LICENSE

08-joystick-whitespace.patch:
	trailing whitespace fixes in drivers/input/joystick

09-gameport-whitespace.patch:
	trailing whitespace fixes in drivers/input/gameport

10-input-whitespace.patch:
	trailing whitespace fixes in drivers/input

11-synaptics-reconnect.patch:
	do not call synaptics_init unless we are ready to do full
        mouse setup or we can oops on resume

12-i8042-interrupt.patch:
	split i8042 interrupt handling into an IRQ handler and a tasklet,
	as with mousedev, evdev and so on we were doing too much work in
	IRQ context

13-i8042-unload.patch:
	Patch from Sau Dan Lee
  	Kill the timer only after removing interrupt handler,
        otherwise there is a chance that interrupt handler will install
        the timer again and it will trigger after module is unloaded.

14-mousedev-multiplexing.patch:
	better multiplex absolute and relative devices; cleanups

I did merge with Linus' tree to resolve conflicts with Eric's latest
changes to logips2pp (hope he does not mind). Please do:
bk pull bk://dtor.bkbits.net/input

The following patches are against your tree rather then Linis' and I will
not post whitespace fixing patches as they are too boring...

There is also a cumulative patch agains Linus' tree at:
http://www.geocities.com/dt_or/input/2_6_6/input-cumulative.patch.gz

-- 
Dmitry
