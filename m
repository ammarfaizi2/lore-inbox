Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263157AbTC1VdN>; Fri, 28 Mar 2003 16:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263158AbTC1VdN>; Fri, 28 Mar 2003 16:33:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:59538 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S263157AbTC1VdM>;
	Fri, 28 Mar 2003 16:33:12 -0500
Date: Fri, 28 Mar 2003 13:40:06 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: more details on laptop keyboard problems, 2.5.66-bk4
Message-Id: <20030328134006.4311dbf3.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0303281617510.1175-100000@dell>
References: <Pine.LNX.4.44.0303281617510.1175-100000@dell>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003 16:26:53 -0500 (EST) "Robert P. J. Day" <rpjday@mindspring.com> wrote:

|   ok, here's a little more info.  as i was booting my dell
| laptop with 2.5.66-bk4, just after the "Starting sendmail"
| message, i got a screenful of
| 
|   atkbd.c: Unknown key (set 0, scancode 0x0, on isa0060/serio1) pressed.
| 
| i did in fact build support for an AT keyboard (CONFIG_KEYBOARD_ATKBD)
| directly into the kernel, since it seemed based on the explanation
| that i needed that.  (to refresh your memory, i have both the built-in
| keyboard and a PS/2 keyboard which is plugged into the combo 
| keyboard/mouse port on the back, and under 2.4.18, both are
| functional at the same time.)
| 
...
| 
|   but one step at a time -- any suggestions regarding that "atkbd.c"
| error??  i'm assuming that i really need that option selected, no?

Any chance that you need to set CONFIG_I8K ?

config I8K
	tristate "Dell laptop support"
	---help---
	  This adds a driver to safely access the System Management Mode
	  of the CPU on the Dell Inspiron 8000. The System Management Mode
	  is used to read cpu temperature and cooling fan status and to
	  control the fans on the I8K portables.

--
~Randy
