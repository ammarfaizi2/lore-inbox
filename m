Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVA2XVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVA2XVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 18:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVA2XVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 18:21:20 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:30340 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261594AbVA2XVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 18:21:17 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Jaco Kroon <jaco@kroon.co.za>
Subject: Re: i8042 access timings
Date: Sat, 29 Jan 2005 18:21:14 -0500
User-Agent: KMail/1.7.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       Linus Torvalds <torvalds@osdl.org>, sebekpi@poczta.onet.pl,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200501260040.46288.sebekpi@poczta.onet.pl> <20050128183955.GA2640@ucw.cz> <41FBEB19.2040105@kroon.co.za>
In-Reply-To: <41FBEB19.2040105@kroon.co.za>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501291821.15762.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 29 January 2005 14:59, Jaco Kroon wrote:
> > Compiling USB 1.1 support does the very same thing as specifying
> > usb-handoff on the command like - tells the BIOS to keep its hands off
> > the USB _and_ PS/2 controllers.
> 
> I'm missing something, I have USB1.1 compiled in, then why does the 
> touchpad not work if it does the very same thing as usb-handoff?

USB initializes very late, after i8042 and psmouse has already run
their probes. So unless there is "usb-handoff" psmouse talks to a fake
BIOS-emulated mouse, not a real touchpad. 

-- 
Dmitry
