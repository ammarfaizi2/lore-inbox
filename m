Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbTA2Niu>; Wed, 29 Jan 2003 08:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbTA2Niu>; Wed, 29 Jan 2003 08:38:50 -0500
Received: from [81.2.122.30] ([81.2.122.30]:46087 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S265939AbTA2Nit>;
	Wed, 29 Jan 2003 08:38:49 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301291348.h0TDmHfu001672@darkstar.example.net>
Subject: Bootscreen suggestions that don't involve kernel modifications
To: Raphael_Schmid@CUBUS.COM (Raphael Schmid)
Date: Wed, 29 Jan 2003 13:48:17 +0000 (GMT)
Cc: rtilley@vt.edu, roy@karlsbakk.net, wa1hco@adelphia.net, rob@r-morris.co.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <398E93A81CC5D311901600A0C9F2928946939B@cubuss2> from "Raphael Schmid" at Jan 29, 2003 02:25:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is not necessarily the init scripts. Each
> distributor can customise these quite easily. The problem
> is (how I see it) divided into two parts:
> 
> 	I. The kernel messages. (And yes, I do know
>       about both, "quiet" and "console=/foo/bar)
> 
> 	II. Both, using "quiet" or "console=/foo/bar",
>       and customising the init scripts only leaves
>       you with a blank, black screen. Now, you might
>       argue how "classic" or "beatieful" black is.
>       But it should be obvious this is an absolute
>       matter of taste. A nice picture is far more
>       appealing, and pleasing, and whatnot.

I don't think it is appropriate to include graphical boot screen
capabilities in the kernel.  There are better ways to achieve what you
want to do:

* Verbose start-up messages on the console
Leave things how they are

* No start up messages on the console
Either use the quiet option, or re-direct the output to serial console
or another virtual terminal.

* Graphical boot screen
Do not have the VGA card configured as a console device at all.  Set
the console output to a serial port for debugging, if necessary.  Have
the bootloader configure the VGA card, and display the graphic.  Boot
in to X, and let X re-configure the VGA card at startup.

Where no console is available for diagnostic messages, the keyboard
LEDs could be lit up in sequence to indicate that the system is
booting.

John.
