Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSIJTlO>; Tue, 10 Sep 2002 15:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318097AbSIJTlO>; Tue, 10 Sep 2002 15:41:14 -0400
Received: from gherkin.frus.com ([192.158.254.49]:905 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S318079AbSIJTkB>;
	Tue, 10 Sep 2002 15:40:01 -0400
Message-Id: <m17oqw9-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: 2.5.X config: USB speedtouch driver
In-Reply-To: <20020910190424.GA22753@kroah.com> "from Greg KH at Sep 10, 2002
 12:04:24 pm"
To: Greg KH <greg@kroah.com>
Date: Tue, 10 Sep 2002 14:44:37 -0500 (CDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=ELM731659032-2809-0_
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ELM731659032-2809-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII

Greg KH wrote:
> On Tue, Sep 10, 2002 at 01:53:45PM -0500, Bob_Tracy wrote:
> > Minor nit: the subject driver depends on ATM, so a config-time check to
> > see if ATM support is enabled is appropriate.
> 
> Agreed, patch? :)

Ok.  You shamed me into it :-).  If I understand how dep_tristate works,
the attached one-liner should do the trick.  Sorry for doing this as an
attachment, but I've seen my mailer mangle stuff when I try to include
it in-line :-(.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------

--ELM731659032-2809-0_
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: attachment; filename=patch34_usbmisc

--- linux/drivers/usb/misc/Config.in.orig	Wed Aug 28 21:02:04 2002
+++ linux/drivers/usb/misc/Config.in	Tue Sep 10 14:39:38 2002
@@ -8,4 +8,4 @@
 dep_tristate '  USB Diamond Rio500 support (EXPERIMENTAL)' CONFIG_USB_RIO500 $CONFIG_USB $CONFIG_EXPERIMENTAL
 dep_tristate '  Tieman Voyager USB Braille display support (EXPERIMENTAL)' CONFIG_USB_BRLVGER $CONFIG_USB $CONFIG_EXPERIMENTAL
 dep_tristate '  USB LCD driver support' CONFIG_USB_LCD $CONFIG_USB
-dep_tristate '  Alcatel Speedtouch ADSL USB Modem' CONFIG_USB_SPEEDTOUCH $CONFIG_USB    
+dep_tristate '  Alcatel Speedtouch ADSL USB Modem' CONFIG_USB_SPEEDTOUCH $CONFIG_USB $CONFIG_ATM

--ELM731659032-2809-0_--
